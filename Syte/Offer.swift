//
//  Offer.swift
//  Syte
//
//  Created by David Jinely on 6/1/19.
//  Copyright © 2019 David Jinely. All rights reserved.
//

import Foundation
open class OfferDetails: Decodable {
    public var ads: [Ad]
    public var currency_symbol: String
    public var currency_tla: String
}

open class Ad: Decodable {
    public var bbCategories = [String]()
    public var brand: String?
    public var categories = [String]()
    public var description: String?
    public var floatOriginalPrice: Double?
    public var floatPrice: Double?
    public var imageUrl: String?
    public var merchant: String?
    public var originalPrice: String?
    public var originalData: OriginalData?
    public var price: String?
    public var sku: String?
    
    public func getFullDescription() -> String {
        var string = ""
        string += "brand: \(brand ?? "")\n"
        string += "category: \(categories)\n"
        string += "bbCategory: \(bbCategories)\n"
        string += "description: \(description ?? "")\n"
        string += "floatPrice: \(floatPrice ?? 0)\n"
        return string
    }
}

open class OriginalData: Decodable {
    public var suitable_for: String?
    public var alternate_image: String?
    public var aw_image_url: String?
    public var aw_product_id: String?
    public var aw_thumb_url: String?
    public var brand_id: String?
    public var brand_name: String?
    public var category_id: String?
    public var category_name: String?
    public var currency: String?
    public var custom_1: String?
    public var custom_2: String?
    public var data_feed_id: String?
    public var delivery_cost: String?
    public var description: String?
    public var display_price: String?
    public var language: String?
    public var merchant_category: String?
    public var merchant_deep_link: String?
    public var merchant_id: String?
    public var merchant_image_url: String?
    public var merchant_name: String?
    public var merchant_product_id: String?
    public var product_name: String?
    public var rrp_price: String?
    public var search_price: String?
    public var store_price: String?
    
    private enum CodingKeys : String, CodingKey {
        case suitable_for = "Fashion:suitable_for"
    }
}
