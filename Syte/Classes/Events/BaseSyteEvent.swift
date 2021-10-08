//
//  BaseSyteEvent.swift
//  Syte
//
//  Created by Artur Tarasenko on 14.09.2021.
//

import Foundation

protocol RequestableEvent {
    func getRequestBodyString() -> String
}

/**
 Class represents Base Syte event. Extend this class and override getRequestBodyString()
 to create a custom event.
 */
public class BaseSyteEvent: RequestableEvent, Codable {
    
    // Syte URL referer
    let syteUrlReferer: String
    
    // Event name
    let name: String
    
    // Array of event tags
    private(set) var eventsTags: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case syteUrlReferer, name, eventsTags
    }
    
    public init(name: String, syteUrlReferer: String, tag: EventsTag) {
        self.name = name
        self.syteUrlReferer = syteUrlReferer
        eventsTags.append(tag.getName())
    }
    
    public init(name: String, syteUrlReferer: String, tags: [EventsTag]) {
        self.name = name
        self.syteUrlReferer = syteUrlReferer
        eventsTags.append(contentsOf: tags.map({ $0.getName() }))
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        syteUrlReferer = try container.decode(String.self, forKey: .syteUrlReferer)
        name = try container.decode(String.self, forKey: .name)
        eventsTags = try container.decode([String].self, forKey: .eventsTags)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(syteUrlReferer, forKey: .syteUrlReferer)
        try container.encode(name, forKey: .name)
        try container.encode(eventsTags, forKey: .eventsTags)
    }
    
    // Get array of tags converted to string (comma separated)
    public func getTagsString() -> String {
        return eventsTags.joined(separator: ",")
    }
    
    // Getter for request body string
    public func getRequestBodyString() -> String {
        return ""
    }
    
}

// MARK: Extension

extension BaseSyteEvent: Equatable {
    
    public static func == (lhs: BaseSyteEvent, rhs: BaseSyteEvent) -> Bool {
        return lhs.syteUrlReferer == rhs.syteUrlReferer
        && lhs.name == rhs.name
        && lhs.eventsTags == rhs.eventsTags
            
    }
    
}
