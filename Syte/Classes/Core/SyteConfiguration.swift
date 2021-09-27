//
//  SyteConfiguration.swift
//  Syte
//
//  Created by Artur Tarasenko on 18.08.2021.
//  Copyright © 2021 Syte.ai. All rights reserved.
//

import Foundation

/**
 SDK configuration
 */

public final class SyteConfiguration {
    
    /**
     Account ID.
     */
    private(set) var accountId: String
    
    /**
     Signature.
     */
    private(set) var signature: String
    
    /**
     Variable to set/get locale. Will be used in requests.
     A locale with an underscore must be used.
     
     Example: "en_US"
     */
    public var locale = "en_US"
    
    /**
     User ID. This value is generated automatically.
     */
    public var userId: String {
        return storage.getUserId()
    }
    
    /**
     Session ID. This value is generated automatically.
     */
    public var sessionId: Int {
        return storage.getSessionId()
    }
    
    /**
     Indicates whether the calls to Syte.getAutoComplete method that are made within 500ms will be saved to queue and invoked.
     (Only the last call made within 500ms will be saved).
     If false, the calls made within 500ms will be ignored.
     */
    public var allowAutoCompletionQueue = true
    
    private var storage: SyteStorage
    
    /**
     Initialize a new `SyteConfiguration`.
     
     - Parameters:
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
