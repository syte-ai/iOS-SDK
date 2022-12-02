//
//  Fallback.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class Fallback: Codable, ReflectedStringConvertible {
    
    public var fallbackMethod: String?
    public var isFallbackActivated: Bool?
    
    enum CodingKeys: String, CodingKey {
        case fallbackMethod = "fallback_method"
        case isFallbackActivated = "is_fallback_activated"
    }
    
}
