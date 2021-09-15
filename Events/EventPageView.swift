//
//  EventPageView.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation

public class EventPageView: BaseSyteEvent {
    
    public let sku: String
    
    enum CodingKeys: String, CodingKey {
        case sku
    }
    
    public init(sku: String, pageName: String) {
        self.sku = sku
        super.init(name: "fe_page_view", syteUrlReferer: pageName, tag: .ecommerce)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sku = try container.decode(String.self, forKey: .sku)
        
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sku, forKey: .sku)
        
        try super.encode(to: encoder)
    }
    
    override public func getRequestBodyString() -> String {
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(self)
        let json = String(data: jsonData ?? Data(), encoding: String.Encoding.utf8)
        return json ?? ""
    }
    
}
