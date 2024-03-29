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
    private let popularSearchKey = "syte_popular_search_pref"
    private let popularSearchLangKey = "syte_popular_search_lang_pref"
    private let textSearchTermKey = "syte_text_search_term_pref"
    
    private let textSearchTermCount = 50
    
    init() {
        clear()
    }
    
    func getSessionId() -> Int {
        var sessionId = -1
        sessionId = storage.integer(forKey: sessionIdPrefKey) ?? -1
        guard sessionId == -1 || needNewSessionId() else { return sessionId }
        
        sessionId = Int(Double.random(in: 0.0...1.0) * 100000000)
        storage.set(sessionId, forKey: sessionIdPrefKey)
        renewSessionIdTimestamp()
        clearViewedProducts()
        clearPopularSearch()
        
        return sessionId
    }
    
    func renewSessionIdTimestamp() {
        storage.set(getCurrentMillis(), forKey: sessionIdTimestampKey)
    }
    
    func clearSessionId() {
        storage.set(-1, forKey: sessionIdPrefKey)
        storage.set(0, forKey: sessionIdTimestampKey)
    }
    
    func clearViewedProducts() {
        storage.set("", forKey: viewedProductsKey)
    }
    
    func getUserId() -> String {
        var userId = ""
        userId = storage.string(forKey: userIdPrefKey) ?? ""
        
        guard userId.isEmpty else { return userId }
        
        userId = UUID().uuidString
        storage.set(userId, forKey: userIdPrefKey)
        
        return userId
    }
    
    func addViewedProduct(sessionSku: String) {
        let viewedProducts = storage.string(forKey: viewedProductsKey) ?? ""
        storage.set(viewedProducts.isEmpty ? sessionSku : viewedProducts + "," + sessionSku, forKey: viewedProductsKey)
    }
    
    func getViewedProducts() -> String {
        storage.string(forKey: viewedProductsKey) ?? ""
    }
    
    func addPopularSearch(data: [String], lang: String) {
        guard !data.isEmpty else { return }
        let joined = data.joined(separator: ",")
        storage.set(joined, forKey: popularSearchKey + lang)
        let popularSearchLang = storage.string(forKey: popularSearchLangKey) ?? ""
        storage.set(popularSearchLang.isEmpty ? lang : popularSearchLang + "," + lang, forKey: popularSearchLangKey)
    }
    
    func getPopularSearch(lang: String) -> String {
        storage.string(forKey: popularSearchKey + lang) ?? ""
    }
    
    func clearPopularSearch() {
        let langs = storage.string(forKey: popularSearchLangKey) ?? ""
        guard !langs.isEmpty else { return }
        for lang in langs.components(separatedBy: ",") {
            storage.set("", forKey: popularSearchKey + lang)
        }
        storage.set("", forKey: popularSearchLangKey)
    }
    
    func addTextSearchTerm(term: String) {
        var textSearchTerms = storage.string(forKey: textSearchTermKey) ?? ""
        defer { storage.set(textSearchTerms.isEmpty ? term : term + "," + textSearchTerms, forKey: textSearchTermKey) }
        guard !textSearchTerms.isEmpty else { return }
        
        var termsList = textSearchTerms.components(separatedBy: ",")
        guard termsList.count >= textSearchTermCount else { return }
        
        termsList.removeLast()
        textSearchTerms = Utils.textSearchTermsString(terms: termsList)
    }
    
    func getTextSearchTerms() -> String {
        storage.string(forKey: textSearchTermKey) ?? ""
    }
    
    private func needNewSessionId() -> Bool {
        var timestamp = 0
        timestamp = storage.integer(forKey: sessionIdTimestampKey) ?? 0
        return getCurrentMillis() - timestamp > 30 * 60 * 1000
    }
    
    private func getCurrentMillis() -> Int {
        Int(NSDate().timeIntervalSince1970 * 1000)
    }
    
    private func clear() {
        storage.removeAllKeys()
    }
    
}
