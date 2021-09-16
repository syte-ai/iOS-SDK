//
//  EventCheckoutComplete.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation

public class EventCheckoutComplete: BaseSyteEvent {
    
    private let id: String
    private let products: [Product]
    private let value: Double
    private let currency: String
    
    enum CodingKeys: String, CodingKey {
        case id, products, value, currency
    }
    
    public init(id: String, value: Double, currency: String, productList: [Product], pageName: String) {
        self.id = id
        self.value = value
        self.currency = currency
        products = productList
        super.init(name: "checkout_complete", syteUrlReferer: pageName, tag: .ecommerce)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        products = try container.decode([Product].self, forKey: .products)
        value = try container.decode(Double.self, forKey: .value)
        currency = try container.decode(String.self, forKey: .currency)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(products, forKey: .products)
        try container.encode(value, forKey: .value)
        try container.encode(currency, forKey: .currency)
        
        try super.encode(to: encoder)
    }
    
    override public func getRequestBodyString() -> String {
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(self)
        let json = String(data: jsonData ?? Data(), encoding: String.Encoding.utf8)
        return json ?? ""
    }
    
}

