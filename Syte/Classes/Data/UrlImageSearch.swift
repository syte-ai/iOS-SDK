//
//  UrlImageSearch.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

public class UrlImageSearch {
    
    private let imageUrl: String
    private let productType: SyteProductType
    private var sku: String?
    private var retrieveOffersForTheFirstBound = true
    private var coordinates: CropCoordinates?
    private var personalizedRanking = false
    
    public init(imageUrl: String, productType: SyteProductType) {
        self.imageUrl = imageUrl
        self.productType = productType
    }
    
    public func getImageUrl() -> String {
        return imageUrl
    }
    
    public func getProductType() -> SyteProductType {
        return productType
    }
    
    public func setSku(_ value: String) {
        sku = value
    }
    
    public func getSku() -> String? {
        return sku
    }
    
    public func setFirstBoundItemsCoordinates(_ value: CropCoordinates) {
        coordinates = value
    }
    
    public func getFirstBoundItemsCoordinates() -> CropCoordinates? {
        return coordinates
    }
    
    public func setRetrieveItemsForTheFirstBound(_ value: Bool) {
        retrieveOffersForTheFirstBound = value
    }
    
    public func isRetrieveItemsForTheFirstBound() -> Bool {
        return retrieveOffersForTheFirstBound
    }
    
    public func setPersonalizedRanking(_ value: Bool) {
        personalizedRanking = value
    }
    
    public func getPersonalizedRanking() -> Bool {
        return personalizedRanking
    }
    
}
