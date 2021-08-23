//
//  RecommendationReturnField.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

/**
 * Values are used in the Recommendation requests (Similar products, Shop the look, Personalization)
 */
public enum RecommendationReturnField: String {
    /**
     * Return only image URL and product ID (SKU). All other fields will be null!
     */
    case imageUrlAndSku = "imageUrl,sku"
    /**
     * Return only image URL. All other fields will be null!
     */
    case imageUrl = "imageUrl"
    /**
     * Return only product ID (SKU). All other fields in will be null!
     */
    case sku = "sku"
    /**
     * Return all fields.
     */
    case all = "*"
    
    public func getName() -> String {
        return self.rawValue
    }
    
}
