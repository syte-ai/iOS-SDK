//
//  InitSyte.swift
//  Syte
//
//  Created by Artur Tarasenko on 18.08.2021.
//  Copyright © 2021 Syte.ai. All rights reserved.
//

import Foundation
import PromiseKit

public final class InitSyte {
    
    private let tag = String(describing: InitSyte.self)
    
    private enum SyteState {
        case idle, initialized
    }
    
    private var configuration: SyteConfiguration?
    private let syteService = SyteService()
    private var sytePlatformSettings: SytePlatformSettings?
    private var state = SyteState.idle
    
    public init() {}
    
    public func startSessionAsync(configuration: SyteConfiguration, _ completion: ((SyteResult<Bool>) -> Void)? = nil) {
        do {
            try InputValidator.validateInput(configuration: configuration)
            self.configuration = configuration
            
            let result = SyteResult<Bool>()
            firstly {
                syteService.initialize(accoundId: configuration.getAccountId())
            }.done { response in
                if response.isSuccessful {
                    self.sytePlatformSettings = response.data
                    self.state = .initialized
                } else {
                    self.state = .idle
                }
                if self.state == .initialized {
                    // TODO: fireEvent && getTextSearchClient
                    //                        fireEvent(new EventInitialization());
                    //                                        getTextSearchClient().getPopularSearchAsync(mConfiguration.getLocale(), result -> {
                    //                                            if (result.isSuccessful && result.data != null && mConfiguration != null) {
                    //                                                mConfiguration.getStorage().addPopularSearch(result.data, mConfiguration.getLocale());
                    //                                            }
                    //                                        });
                }
                result.data = response.isSuccessful
                result.isSuccessful = response.isSuccessful
                result.resultCode = response.resultCode
                result.errorMessage = response.errorMessage
            }.catch { error in
                result.isSuccessful = false
                result.errorMessage = error.localizedDescription
                result.data = false
            }.finally {
                completion?(result)
            }
        } catch SyteError.wrongInput(let message) {
            SyteLogger.e(tag: tag, message: message)
            let syteResult = SyteResult<Bool>()
            syteResult.data = false
            syteResult.errorMessage = message
            completion?(syteResult)
            return
        } catch let error {
            SyteLogger.e(tag: tag, message: error.localizedDescription)
            let syteResult = SyteResult<Bool>()
            syteResult.data = false
            syteResult.errorMessage = error.localizedDescription
            completion?(syteResult)
            return
        }
    }
    
    public func getConfiguration() -> SyteConfiguration? {
        return configuration
    }
    
    public func setConfiguration(configuration: SyteConfiguration) throws {
        try verifyInitialized()
        self.configuration = configuration
        
    }
    
    public func getSytePlatformSettings() -> SytePlatformSettings? {
        return state == .initialized ? sytePlatformSettings : nil
    }
    
    private func verifyInitialized() throws {
        guard state == .initialized else { throw SyteError.initializationFailed(message: "Syte is not initialized.")}
    }
    
}
