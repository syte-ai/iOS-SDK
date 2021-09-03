//
//  Item.swift
//  Syte
//
//  Created by Artur Tarasenko on 31.08.2021.
//

import Foundation

public class Item: Codable, ReflectedStringConvertible {
    
    private(set) var floatPrice: Double?
    private(set) var originalPrice: String?
    private(set) var parentSku: String?
    private(set) var merchant: String?
    private(set) var description: String?
    private(set) var offer: String?
    private(set) var originalData: [String: JSONValue]?
    private(set) var price: String?
    private(set) var imageUrl: String?
    private(set) var bbCategories: [String]?
    private(set) var id: String?
    private(set) var floatOriginalPrice: Double?
    private(set) var categories: [String]?
    private(set) var sku: String?
    private(set) var brand: String?
    
    enum CodingKeys: String, CodingKey {
        case floatPrice, originalPrice, merchant, description, offer, price, imageUrl, bbCategories, id, floatOriginalPrice, categories, sku, brand
        case originalData = "original_data"
        case parentSku = "parent_sku"
    }
    
}
