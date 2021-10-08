//
//  Personalization.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

/**
 Class that is used to configure the Personalization requests.
 NOTE: you MUST add at least one viewed product in Syte.addViewedItem(String)
 for the Personalization functionality to work.
 */
public class Personalization {
    
    /// Page Name
    public var syteUrlReferer = "mobile_sdk"
    
    /// Number of results to return
    public var limit: Int = 7
    
    /// Model version
    public var modelVersion = "A"
    
    /// Product SKU or ID (the same as provided in the product data feed)
    public var sku: String?
    
    /// Configure what fields must be returned in response. All fields will be returned by default.
    /// In case the value is changed, the result will only contain the chosen fields. All other ones will be nil!
    public var fieldsToReturn: RecommendationReturnField = .all
    
    /// You can use options to include custom parameters
    public var options = [String: String]()
    
    public init() {}
    
}
