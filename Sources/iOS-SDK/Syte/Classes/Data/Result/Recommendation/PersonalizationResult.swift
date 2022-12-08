//
//  PersonalizationResult.swift
//  Syte
//
//  Created by Artur Tarasenko on 17.09.2021.
//

import Foundation

/**
 A class that represents the result for Personalization call
 */
public class PersonalizationResult: Codable, ReflectedStringConvertible {
    
    /// Retrieved items
    private(set) public var data: [Item]?
    
    enum CodingKeys: String, CodingKey {
        case data = "results"
    }
    
}
