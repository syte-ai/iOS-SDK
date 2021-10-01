//
//  EventTextShowResults.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation

/**
 This event should be sent to Syte every time results for a specific text search are shown
 */
public class EventTextShowResults: BaseSyteEvent {
    
    // User search query
    private let query: String
    
    // TextSearchEventType
    private let type: String
    
    // The number of displayed results
    private let exactCount: Int
    
    enum CodingKeys: String, CodingKey {
        case query, type
        case exactCount = "exact_count"
    }
    
    public init(query: String, type: String, exactCount: Int, pageName: String) {
        self.query = query
        self.type = type
        self.exactCount = exactCount
        super.init(name: "fe_text_show_results", syteUrlReferer: pageName, tag: .textSearch)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        query = try container.decode(String.self, forKey: .query)
        type = try container.decode(String.self, forKey: .type)
        exactCount = try container.decode(Int.self, forKey: .exactCount)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(query, forKey: .query)
        try container.encode(type, forKey: .type)
        try container.encode(exactCount, forKey: .exactCount)
        try super.encode(to: encoder)
    }
    
    override public func getRequestBodyString() -> String {
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(self)
        let json = String(data: jsonData ?? Data(), encoding: String.Encoding.utf8)
        return json ?? ""
    }
    
}
