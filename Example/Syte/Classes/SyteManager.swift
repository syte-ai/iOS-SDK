//
//  SyteManager.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 10.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Syte

class SyteMaganer {
    
    static let shared = SyteMaganer()
    
    var isInitialized: Bool {
        return SyteMaganer.shared.syte != nil
    }
    
    private var syte: Syte?
    
    private init() {}
    
    public func initialize(_ completion: @escaping () -> Void) {
        let configuration = SyteConfiguration(accountId: "9165", signature: "601c206d0a7f780efb9360f3")
        Syte.initialize(configuration: configuration) { [weak self] result in
            guard let strongSelf = self else { return }
            guard let data = result.data else { return }
            strongSelf.syte = data
            completion()
        }
    }
    
    public func getBounds(requestData: UrlImageSearch, completion: @escaping (SyteResult<BoundsResult>?) -> Void) {
        guard let syte = syte else { completion(nil); return }
        syte.getBounds(requestData: requestData, completion: completion)
    }
    
    public func getBoundsWild(requestData: ImageSearch, completion: @escaping (SyteResult<BoundsResult>?) -> Void) {
        guard let syte = syte else { completion(nil); return }
        syte.getBoundsWild(requestData: requestData, completion: completion)
    }
    
    public func fire(event: BaseSyteEvent) {
        guard let syte = syte else { return }
        syte.fire(event: event)
    }
    
    public func setSetViewedItem(sku: String) throws {
        try syte?.addViewedItem(sku: sku)
    }
    
    public func getViewedProducts() -> [String] {
        return Array(syte?.getViewedProducts() ?? [])
    }
    
    public func setLocale(_ locale: String) {
        syte?.getConfiguration()?.locale = locale
    }
    
    public func getLocale() -> String {
        return syte?.getConfiguration()?.locale ?? ""
    }
    
}
