//
//  Item.swift
//  Syte
//
//  Created by Artur Tarasenko on 31.08.2021.
//

import Foundation

/**
 Represents Item entity
 */
public class Item: Codable, ReflectedStringConvertible {
    
    // Float price
    private(set) public var floatPrice: Double?
    
    // Original price
    private(set) public var originalPrice: String?
    
    // Parent SKU (product ID)
    private(set) public var parentSku: String?
    
    // Merchant
    private(set) public var merchant: String?
    
    // Description
    private(set) public var description: String?
    
    // Item Url
    private(set) public var offer: String?
    
    // Original data. This data can be unique for each account ID
    private(set) public var originalData: [String: JSONValue]?
    
    // Price
    private(set) public var price: String?
    
    // Image Url
    private(set) public var imageUrl: String?
    
    // BB categories
    private(set) public var bbCategories: [String]?
    
    // ID
    private(set) public var id: String?
    
    // Float original price
    private(set) public var floatOriginalPrice: Double?
    
    // Categories
    private(set) public var categories: [String]?
    
    // SKU (product ID)
    private(set) public var sku: String?
    
    // Brand
    private(set) public var brand: String?
    
    enum CodingKeys: String, CodingKey {
        case floatPrice, originalPrice, merchant, description, offer, price, imageUrl, bbCategories, id, floatOriginalPrice, categories, sku, brand
        case originalData = "original_data"
        case parentSku = "parent_sku"
    }
    
}
