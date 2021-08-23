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
    
    private var accountId: String
    private var signature: String
    
    private var locale = "en_Us"
    private var userId: String
    private var sessionId: String
    
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
        sessionId = String(storage.getSessionId())
        userId = storage.getUserId()
    }
    
    /**
     Method to set locale. Will be used in requests.
     
     - parameters:
     - locale: locale to use
     */
    public func setLocale(locale: String) {
        self.locale = locale
    }
    
    /**
     Getter for locale
     
     - returns: locale to use.
     */
    public func getLocale() -> String {
        return locale
    }
    
    /**
     Getter for account ID
     
     - returns: account ID
     */
    public func getAccountId() -> String {
        return accountId
    }
    
    /**
     Getter for signature
     
     - returns: signature
     */
    public func getApiSignature() -> String {
        return signature
    }
    
    /**
     Getter for user ID
     
     - returns: User ID. This value is generated automatically.
     */
    public func getUserId() -> String {
        return storage.getUserId()
    }
    
    /**
     Getter for session ID
     
     - returns: Session ID. This value is generated automatically.
     */
    public func getSessionId() -> Int {
        return storage.getSessionId()
    }
    
    public func addViewedProduct(sessionSku: String) {
        storage.addViewedProduct(sessionSku: sessionSku)
    }
    
    public func getViewedProducts() -> Set<String> {
        let viewedProductsString = storage.getViewedProducts()
        return viewedProductsString.isEmpty ? Set<String>() : Set(viewedProductsString.components(separatedBy: ","))
    }
    
    public func getStorage() -> SyteStorage {
        return storage
    }
    
}
