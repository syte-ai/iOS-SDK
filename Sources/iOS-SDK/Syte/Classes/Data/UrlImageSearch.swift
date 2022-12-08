//
//  UrlImageSearch.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

/**
 Class that is used to configure the Url image search.
 */
public class UrlImageSearch {
    
    /// The main image URL from the PDP
    public let imageUrl: String
    
    /// The related syte product for the request. Should be discovery_button OR camera
    public let productType: SyteProductType
    
    /// Product SKU or ID (the same as provided in the product data feed)
    public var sku: String?
    
    /// Items for the first bound will be retrieved by default
    public var retrieveOffersForTheFirstBound = true
    
    /// The crop coordinates of the item, should be relative ranging from 0.0 to 1.0
    public var coordinates: CropCoordinates?
    
    /// Enabling the personalized ranking will use the list of viewed products (skus viewed during the session) and apply a behavioral match ranking strategy on the set of results.
    public var personalizedRanking = false
    
    /// You can use options to include custom parameters
    public var options = [String: String]()
    
    public init(imageUrl: String, productType: SyteProductType) {
        self.imageUrl = imageUrl
        self.productType = productType
    }
    
}
