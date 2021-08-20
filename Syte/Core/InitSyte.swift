//
//  InitSyte.swift
//  Syte
//
//  Created by Artur Tarasenko on 18.08.2021.
//  Copyright © 2021 Syte.ai. All rights reserved.
//

import Foundation

final class InitSyte {
    
    private static let tag = String(describing: InitSyte.self)
    
    private enum SyteState {
        case idle, initialized
    }
    
    private var configuration: SyteConfiguration?
    
//    private var remoteDataSource: SyteRemoteDataSource?
//    private var sytePlatformSettings: SytePlatformSettings?
//    private var eventsRemoteDataSource: EventsRemoteDataSource?
    private var state = SyteState.idle
        
    public func startSession(configuration: SyteConfiguration, _ completion: SyteResult<Bool>) {
        
    }
    
    public func startSessionAsync(configuration: SyteConfiguration, _ completion: SyteResult<Bool>) {
        
    }
    
    public func getConfiguration() -> SyteConfiguration? {
        return configuration
    }
    
    public func setConfiguration(configuration: SyteConfiguration) throws {
        
    }
    
//    public func getSytePlatformSettings() -> SytePlatformSettings {
//        verifyInitialized()
//        return mSytePlatformSettings
//    }
    
//    public func getProductRecommendationClient() -> ProductRecommendationClient {
//        verifyInitialized()
//        return ProductRecommendationClientImpl(mRemoteDataSource, mSytePlatformSettings)
//    }
    
}
