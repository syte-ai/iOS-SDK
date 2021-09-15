//
//  Product.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation

public class Product: Codable {
    
    private let sku: String
    private let quantity: Int
    private let price: Double
    
    enum CodingKeys: String, CodingKey {
        case sku, quantity, price
    }
    
    public init(sku: String, quantity: Int, price: Double) {
        self.sku = sku
        self.quantity = quantity
        self.price = price
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sku = try container.decode(String.self, forKey: .sku)
        quantity = try container.decode(Int.self, forKey: .quantity)
        price = try container.decode(Double.self, forKey: .price)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sku, forKey: .sku)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(price, forKey: .price)
    }

}
