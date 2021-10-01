//
//  EventProductsAddedToCart.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation

/**
 This event should be sent to Syte every time a user adds a products to cart
 */
public class EventProductsAddedToCart: BaseSyteEvent {
    
    private let products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case products
    }
    
    public init(productList: [Product], pageName: String) {
        products = productList
        super.init(name: "products_added_to_cart", syteUrlReferer: pageName, tag: .ecommerce)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        products = try container.decode([Product].self, forKey: .products)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(products, forKey: .products)
        try super.encode(to: encoder)
    }
    
    override public func getRequestBodyString() -> String {
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(self)
        let json = String(data: jsonData ?? Data(), encoding: String.Encoding.utf8)
        return json ?? ""
    }
    
}
