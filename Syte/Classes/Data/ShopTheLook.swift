//
//  ShopTheLook.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

/**
 Class that is used to configure the 'Shop the look' requests.
 */
public class ShopTheLook {
    
    // Product SKU or ID (the same as provided in the product data feed)
    private(set) var sku: String
    
    // The Shop the look image URL (if exists) or the main image url from the PDP
    private(set) var imageUrl: String
    
    // Enabling the personalized ranking will use the list of viewed products (skus viewed during the session) and apply a behavioral match ranking strategy on the set of results.
    public var personalizedRanking = false
    
    // Page Name
    public var syteUrlReferer = "mobile_sdk"
    
    // Number of results to return
    public var limit: Int = 7
    
    // Number of results to return per detected bound
    public var limitPerBound = -1
    
    // Syte original item
    public var syteOriginalItem: String?
    
    // Configure what fields must be returned in response. All fields will be returned by default.
    // In case the value is changed, the result will only contain the chosen fields. All other ones will be nil!
    public var fieldsToReturn: RecommendationReturnField = .all
    
    // You can use options to include custom parameters
    public var options = [String: String]()
    
    public init(sku: String, imageUrl: String) {
        self.sku = sku
        self.imageUrl = imageUrl
    }
    
}
