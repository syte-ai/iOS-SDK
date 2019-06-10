//
//  Config.swift
//  Syte
//
//  Created by David Jinely on 6/2/19.
//  Copyright © 2019 David Jinely. All rights reserved.
//

import Foundation

public struct Config {
    enum Catalog: String {
        case `default`, home, general
    }
    enum Gender: String {
        case male, female, boy, girl, hd, general
    }
    
    var accountID: String?
    var token: String?
    var features = [String: AnyObject]()
    var catalog = Catalog.default
    var currency = "USD"
    var gender = Gender.general
    var category: String?
    var categories = [String]()
    
    init() {}
    
    init(accountID: String, token: String, rawData: AnyObject) {
        self.accountID = accountID
        self.token = token
        
        let featurePath = "data.products.syteapp.features"
        if let features = rawData.value(forKeyPath: featurePath) as? [String: AnyObject] {
            self.features = features
        }
        
        let catalogPath = "data.products.syteapp.catalog"
        if let raw = rawData.value(forKeyPath: catalogPath) as? String,
            let data = Config.Catalog(rawValue: raw) {
            catalog = data
        }
        
        let genderPath = "data.products.syteapp.gender"
        if let raw = rawData.value(forKeyPath: genderPath) as? String,
            let data = Config.Gender(rawValue: raw) {
            gender = data
        }
        
        let currencyPath = "data.products.syteapp.currency"
        if let raw = rawData.value(forKeyPath: currencyPath) as? String {
            currency = raw
        }
    }
}
