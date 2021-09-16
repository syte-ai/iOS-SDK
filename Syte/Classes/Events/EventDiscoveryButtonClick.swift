//
//  EventDiscoveryButtonClick.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation

public class EventDiscoveryButtonClick: BaseSyteEvent {
    
    private let imageSrc: String
    private let placement: String
    
    enum CodingKeys: String, CodingKey {
        case imageSrc, placement
    }
    
    public init(imageSrc: String, placement: String, pageName: String) {
        self.imageSrc = imageSrc
        self.placement = placement
        super.init(name: "fe_discovery_button_click", syteUrlReferer: pageName, tag: .discoveryButton)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imageSrc = try container.decode(String.self, forKey: .imageSrc)
        placement = try container.decode(String.self, forKey: .placement)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(imageSrc, forKey: .imageSrc)
        try container.encode(placement, forKey: .placement)
        try super.encode(to: encoder)
    }
    
    override public func getRequestBodyString() -> String {
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(self)
        let json = String(data: jsonData ?? Data(), encoding: String.Encoding.utf8)
        return json ?? ""
    }
    
}
