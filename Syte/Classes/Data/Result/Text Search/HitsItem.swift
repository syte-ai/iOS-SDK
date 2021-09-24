//
//  HitsItem.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.09.2021.
//

import Foundation

public class HitsItem: Codable, ReflectedStringConvertible {
    
    private(set) public var tagging: Tagging?
    private(set) public var floatPrice: String?
    private(set) public var originalPrice: String?
    private(set) public var keywordsCompound: String?
    private(set) public var merchant: String?
    private(set) public var description: String?
    private(set) public var matchedQueries: String?
    private(set) public var title: String?
    private(set) public var bbCategory: String?
    private(set) public var tags: [String]?
    private(set) public var offer: String?
    private(set) public var syteCategory: String?
    private(set) public var price: String?
    private(set) public var imageUrl: String?
    private(set) public var id: String?
    private(set) public var categories: [String]?
    private(set) public var floatOriginalPrice: String?
    private(set) public var brand: String?
    
    internal(set) public var originalData: [String: JSONValue]?
    
    enum CodingKeys: String, CodingKey {
        case tagging, floatPrice, originalPrice, merchant, description, title, tags, offer, price, imageUrl, id, categories, floatOriginalPrice, brand
        case originalData = "original_data"
        case keywordsCompound = "keywords_compound"
        case matchedQueries = "matched_queries"
        case bbCategory = "bb_category"
        case syteCategory = "syte_category"
    }
    
}
