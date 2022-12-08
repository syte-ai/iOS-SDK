//
//  OriginalData.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.09.2021.
//

import Foundation

public class OriginalData: Codable, ReflectedStringConvertible {
    
    private(set) public var imageLink: String?
    private(set) public var gender: String?
    private(set) public var saleprice: String?
    private(set) public var discount: String?
    private(set) public var additionalImageLink: String?
    private(set) public var size: String?
    private(set) public var price: String?
    private(set) public var availability: String?
    private(set) public var name: String?
    private(set) public var id: String?
    private(set) public var productsURL: String?
    private(set) public var currency: String?
    private(set) public var brand: String?
    private(set) public var productCategory: String?
    
    enum CodingKeys: String, CodingKey {
        case gender, saleprice, discount, size, price, availability, name, id, currency, brand
        case imageLink = "image_link"
        case additionalImageLink = "additional_image_link"
        case productsURL = "products_URL"
        case productCategory = "product_category"
    }
    
}
