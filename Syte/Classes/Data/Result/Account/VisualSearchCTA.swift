//
//  VisualSearchCTA.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class VisualSearchCTA: Codable {
    
    public var onFocus: Bool?
    public var header: Bool?
    public var noResults: Bool?
    
    enum CodingKeys: String, CodingKey {
        case header
        case onFocus = "on_focus"
        case noResults = "no_results"
    }
    
}
