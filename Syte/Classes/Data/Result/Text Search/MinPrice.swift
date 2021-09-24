//
//  MinPrice.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.09.2021.
//

import Foundation

public class MinPrice: Codable, ReflectedStringConvertible {
    
    private(set) public var value: Double?
    private(set) public var displayName: String?
    private(set) public var order: Int?
    
    enum CodingKeys: String, CodingKey {
        case value, order
        case displayName = "display_name"
    }
    
}
