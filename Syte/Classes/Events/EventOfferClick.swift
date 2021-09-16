//
//  EventOfferClick.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation

public class EventOfferClick: BaseSyteEvent {
    
    private let sku: String
    private let position: Int
    
    enum CodingKeys: String, CodingKey {
        case sku, position
    }
    
    public init(sku: String, position: Int, pageName: String) {
        self.sku = sku
        self.position = position
        super.init(name: "fe_offer_click", syteUrlReferer: pageName, tags: [.discoveryButton, .camera])
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sku = try container.decode(String.self, forKey: .sku)
        position = try container.decode(Int.self, forKey: .position)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sku, forKey: .sku)
        try container.encode(position, forKey: .position)
        try super.encode(to: encoder)
    }
    
    override public func getRequestBodyString() -> String {
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(self)
        let json = String(data: jsonData ?? Data(), encoding: String.Encoding.utf8)
        return json ?? ""
    }
    
}
