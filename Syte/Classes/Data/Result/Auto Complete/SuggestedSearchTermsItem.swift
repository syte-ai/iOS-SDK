//
//  SuggestedSearchTermsItem.swift
//  Syte
//
//  Created by Artur Tarasenko on 22.09.2021.
//

import Foundation

public class SuggestedSearchTermsItem: Codable, ReflectedStringConvertible {
    
    private(set) public var popularity: Int?
    private(set) public var searchTerm: String?
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case searchTerm = "search_term"
    }
    
}
