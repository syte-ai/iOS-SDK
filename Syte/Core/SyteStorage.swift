//
//  SyteStorage.swift
//  Syte
//
//  Created by Artur Tarasenko on 18.08.2021.
//  Copyright © 2021 Syte.ai. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class SyteStorage {
    
    private static let tag = String(describing: SyteStorage.self)
    private let storage = KeychainWrapper.standard
    
    private let sessionIdPrefKey = "syte_session_id_pref"
    private let userIdPrefKey = "syte_user_id_pref"
    private let sessionIdTimestampKey = "syte_session_id_time_pref"
    private let viewedProductsKey = "syte_viewed_products_pref"
    
    public func getSessionId() -> Int {
        var sessionId = -1
        sessionId = storage.integer(forKey: sessionIdPrefKey) ?? 1
        guard sessionId == -1 || needNewSessionId() else { return sessionId }
        
        sessionId = Int(Double.random(in: 0.0...1.0) * 100000000)
        storage.set(sessionId, forKey: sessionIdPrefKey)
        renewSessionIdTimestamp()
        clearViewedProducts()
        
        return sessionId
    }

    public func renewSessionIdTimestamp() {
        storage.set(getCurrentMillis(), forKey: sessionIdTimestampKey)
    }
    
    public func clearSessionId() {
        storage.set(-1, forKey: sessionIdPrefKey)
        storage.set(0, forKey: sessionIdTimestampKey)
    }
    
    public func clearViewedProducts() {
        storage.set("", forKey: viewedProductsKey)
    }
    
    public func getUserId() -> String {
        var userId = ""
        userId = storage.string(forKey: userIdPrefKey) ?? ""
        
        guard userId.isEmpty else { return userId }
        
        userId = UUID().uuidString
        storage.set(userId, forKey: userIdPrefKey)
        
        return userId
    }
    
    public func addViewedProduct(sessionSku: String) {
        let viewedProducts = storage.string(forKey: viewedProductsKey) ?? ""
        storage.set(viewedProducts.isEmpty ? sessionSku : viewedProducts + "," + sessionSku, forKey: viewedProductsKey)
    }
    
    public func getViewedProducts() -> String {
        return storage.string(forKey: viewedProductsKey) ?? ""
    }
   
    private func needNewSessionId() -> Bool {
        var timestamp = 0
        timestamp = storage.integer(forKey: sessionIdTimestampKey) ?? 0
        return getCurrentMillis() - timestamp > 30 * 60 * 1000
    }
    
    private func getCurrentMillis() -> Int {
        return Int(NSDate().timeIntervalSince1970 * 1000)
    }
    
}
