//
//  EventCheckoutStart.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation

public class EventCheckoutStart: BaseSyteEvent {
    
    private let products: [Product]
    private let value: Double
    private let currency: String
    
    enum CodingKeys: String, CodingKey {
        case products, value, currency
    }
    
    public init(price: Double, currency: String, productList: [Product], pageName: String) {
        self.value = price
        self.currency = currency
        products = productList
        super.init(name: "checkout_start", syteUrlReferer: pageName, tag: .ecommerce)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        products = try container.decode([Product].self, forKey: .products)
        value = try container.decode(Double.self, forKey: .value)
        currency = try container.decode(String.self, forKey: .currency)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
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

