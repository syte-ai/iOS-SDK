//
//  BaseRemoteDataSource.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation

class BaseRemoteDataSource {
    
    private static let tag = String(describing: BaseRemoteDataSource.self)
    
    var configuration: SyteConfiguration
    
    init(configuration:  SyteConfiguration) {
        self.configuration = configuration
    }

    func setConfiguration(_ configuration: SyteConfiguration) {
        SyteLogger.v(tag: BaseRemoteDataSource.tag, message: "applyConfiguration")
        self.configuration = configuration
    }

    func renewTimestamp() {
        configuration.getStorage().renewSessionIdTimestamp()
    }

}
