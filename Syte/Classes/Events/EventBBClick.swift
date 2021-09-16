//
//  EventBBClick.swift
//  Syte
//
//  Created by Artur Tarasenko on 14.09.2021.
//

import Foundation

public class EventBBClick: BaseSyteEvent {
    
    private let imageUrl: String
    private let category: String
    private let gender: String
    private let catalog: String
    
    enum CodingKeys: String, CodingKey {
        case category, gender, catalog
        case imageUrl = "image_url"
    }
    
    public init(imageUrl: String, category: String, gender: String, catalog: String, pageName: String) {
        self.imageUrl = imageUrl
        self.category = category
        self.gender = gender
        self.catalog = catalog
        super.init(name: "fe_bb_bb_click", syteUrlReferer: pageName, tag: .camera)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        category = try container.decode(String.self, forKey: .category)
        gender = try container.decode(String.self, forKey: .gender)
        catalog = try container.decode(String.self, forKey: .catalog)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(category, forKey: .category)
        try container.encode(gender, forKey: .gender)
        try container.encode(catalog, forKey: .catalog)
        
        try super.encode(to: encoder)
    }
    
    override public func getRequestBodyString() -> String {
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(self)
        let json = String(data: jsonData ?? Data(), encoding: String.Encoding.utf8)
        return json ?? ""
    }
    
}
