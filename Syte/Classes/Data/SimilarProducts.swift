//
//  SimilarProducts.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

public class SimilarProducts {
    
    private(set) public var sku: String
    private(set) public var imageUrl: String
    public var personalizedRanking = false
    public var syteUrlReferer = "mobile_sdk"
    public var limit: Int = 7
    public var fieldsToReturn: RecommendationReturnField = .all
    public var options = [String: String]()

    public init(sku: String, imageUrl: String) {
        self.sku = sku
        self.imageUrl = imageUrl
    }
    
}
