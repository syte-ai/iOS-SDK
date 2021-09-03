//
//  UrlImageSearch.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

public class UrlImageSearch {
    
    public let imageUrl: String
    public let productType: SyteProductType
    public var sku: String?
    public var retrieveOffersForTheFirstBound = true
    public var coordinates: CropCoordinates?
    public var personalizedRanking = false
    public var options = [String: String]()
    
    public init(imageUrl: String, productType: SyteProductType) {
        self.imageUrl = imageUrl
        self.productType = productType
    }
    
}
