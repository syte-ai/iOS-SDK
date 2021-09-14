//
//  SyteConfiguration.swift
//  Syte
//
//  Created by Artur Tarasenko on 18.08.2021.
//  Copyright © 2021 Syte.ai. All rights reserved.
//

import Foundation

/// SDK configuration

public final class SyteConfiguration {
    
    private(set) var accountId: String
    private(set) var signature: String
    
    public var locale = "en_US"
    public var userId: String {
        return storage.getUserId()
    }
    public var sessionId: Int {
        return storage.getSessionId()
    }
    
    private var storage: SyteStorage
    
    /**
     Initialize a new `SyteConfiguration`.
     
     - parameters:
        - accountId: contact Syte for this value
        - signature: contact Syte for this value
     */
    public init(accountId: String, signature: String) {
        self.accountId = accountId
        self.signature = signature
        storage = SyteStorage()
    }
    
    func addViewedProduct(sessionSku: String) {
        storage.addViewedProduct(sessionSku: sessionSku)
    }
    
    func getViewedProducts() -> Set<String> {
        let viewedProductsString = storage.getViewedProducts()
        return viewedProductsString.isEmpty ? Set<String>() : Set(viewedProductsString.components(separatedBy: ","))
    }
    
    func getStorage() -> SyteStorage {
        return storage
    }
    
}
