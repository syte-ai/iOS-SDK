//
//  Item.swift
//  Syte
//
//  Created by Artur Tarasenko on 31.08.2021.
//

import Foundation

public class Item: Codable, ReflectedStringConvertible {
    
    private(set) public var floatPrice: Double?
    private(set) public var originalPrice: String?
    private(set) public var parentSku: String?
    private(set) public var merchant: String?
    private(set) public var description: String?
    private(set) public var offer: String?
    private(set) public var originalData: [String: JSONValue]?
    private(set) public var price: String?
    private(set) public var imageUrl: String?
    private(set) public var bbCategories: [String]?
    private(set) public var id: String?
    private(set) public var floatOriginalPrice: Double?
    private(set) public var categories: [String]?
    private(set) public var sku: String?
    private(set) public var brand: String?
    
    enum CodingKeys: String, CodingKey {
        case floatPrice, originalPrice, merchant, description, offer, price, imageUrl, bbCategories, id, floatOriginalPrice, categories, sku, brand
        case originalData = "original_data"
        case parentSku = "parent_sku"
    }
    
}
