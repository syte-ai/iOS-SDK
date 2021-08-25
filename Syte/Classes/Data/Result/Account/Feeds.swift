//
//  Feeds.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class Feeds: Codable {
    
    public var general: [String]?
    public var relatedLooks: [String]?
    public var fashion: [String]?
    public var home: [String]?
    
    enum CodingKeys: String, CodingKey {
        case general, fashion, home
        case relatedLooks = "related_looks"
    }

}
