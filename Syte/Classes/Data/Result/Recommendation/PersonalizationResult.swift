//
//  PersonalizationResult.swift
//  Syte
//
//  Created by Artur Tarasenko on 17.09.2021.
//

import Foundation

public class PersonalizationResult: Codable, ReflectedStringConvertible {
    
    private(set) public var data: [Item]?
    
    enum CodingKeys: String, CodingKey {
        case data = "results"
    }
    
}
