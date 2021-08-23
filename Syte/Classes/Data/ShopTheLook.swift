//
//  ShopTheLook.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

public class ShopTheLook {
    
    private var sku: String
    private var imageUrl: String
    private var personalizedRanking = false
    private var syteUrlReferer = "mobile_sdk"
    private var limit: Int = 7
    private var limitPerBound = -1
    private var syteOriginalItem: String?
    private var fieldsToReturn: RecommendationReturnField = .all
    
    public init(sku: String, imageUrl: String) {
        self.sku = sku
        self.imageUrl = imageUrl
    }
    
    public func getSku() -> String {
        return sku
    }
    
    public func getImageUrl() -> String {
        return imageUrl
    }
    
    public func setFieldsToReturn(fieldsToReturn: RecommendationReturnField) {
        self.fieldsToReturn = fieldsToReturn
    }
    
    public func getFieldsToReturn() -> RecommendationReturnField {
        return fieldsToReturn
    }
    
    public func setPersonalizedRanking(personalizedRanking: Bool) {
        self.personalizedRanking = personalizedRanking
    }
    
    public func getPersonalizedRanking() -> Bool {
        return personalizedRanking
    }
    
    public func setSyteUrlReferer(syteUrlReferer: String) {
        self.syteUrlReferer = syteUrlReferer
    }
    
    public func getSyteUrlReferer() -> String {
        return syteUrlReferer
    }
    
    public func setLimit(limit: Int) {
        self.limit = limit
    }
    
    public func getLimit() -> Int {
        return limit
    }
    
    public func setLimitPerBound(limit: Int) {
        limitPerBound = limit
    }
    
    public func getLimitPerBound() -> Int {
        return limitPerBound
    }
    
    public func setSyteOriginalItem(originalItem: String) {
        syteOriginalItem = originalItem
    }
    
    public func getSyteOriginalItem() -> String? {
        return syteOriginalItem
    }
    
}
