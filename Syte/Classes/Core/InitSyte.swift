//
//  InitSyte.swift
//  Syte
//
//  Created by Artur Tarasenko on 18.08.2021.
//  Copyright © 2021 Syte.ai. All rights reserved.
//

import Foundation

public final class InitSyte {
    
    private let tag = String(describing: InitSyte.self)
    
    private enum SyteState {
        case idle, initialized
    }
    
    private var configuration: SyteConfiguration?
    
//    private var remoteDataSource: SyteRemoteDataSource?
//    private var sytePlatformSettings: SytePlatformSettings?
//    private var eventsRemoteDataSource: EventsRemoteDataSource?
    private var state = SyteState.idle
    
    public init() {}
        
    public func startSession(configuration: SyteConfiguration) -> SyteResult<Bool> {
        do {
            try InputValidator.validateInput(configuration: configuration)
        } catch SyteError.wrongInput(let message) {
            SyteLogger.e(tag: tag, message: message)
            let syteResult = SyteResult<Bool>()
            syteResult.data = false
            syteResult.errorMessage = message
            return syteResult
        } catch let error {
            SyteLogger.e(tag: tag, message: error.localizedDescription)
        }
        self.configuration = configuration
        
        //        mRemoteDataSource = new SyteRemoteDataSource(mConfiguration);
        //                mEventsRemoteDataSource = new EventsRemoteDataSource(mConfiguration);
        let result = SyteResult<Bool>()
//        let responseResult = SyteResult<SytePlatformSettings>()
        
        
//                try {
//                    responseResult = mRemoteDataSource.initialize();
//                    mSytePlatformSettings = responseResult.data;
//                    result.data = responseResult.isSuccessful;
//                    result.isSuccessful = responseResult.isSuccessful;
//                    result.errorMessage = responseResult.errorMessage;
//                    mState = SyteState.INITIALIZED;
//                } catch (Exception e) {
//                    result.data = false;
//                    result.isSuccessful = false;
//                    result.errorMessage = e.getMessage();
//                    mState = SyteState.IDLE;
//                }
//                result.resultCode = responseResult.resultCode;
//                if (mState == SyteState.INITIALIZED) {
//                    fireEvent(new EventInitialization());
//                }
        return result
    }
    
    public func startSessionAsync(configuration: SyteConfiguration, _ completion: (SyteResult<Bool>) -> Void) {
        
    }
    
    public func getConfiguration() -> SyteConfiguration? {
        return configuration
    }
    
    public func setConfiguration(configuration: SyteConfiguration) throws {
        
    }
    
}
