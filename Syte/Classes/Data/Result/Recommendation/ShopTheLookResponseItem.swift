//
//  ShopTheLookResponseItem.swift
//  Syte
//
//  Created by Artur Tarasenko on 17.09.2021.
//

import Foundation

public class ShopTheLookResponseItem: Codable, ReflectedStringConvertible {
    
    private(set) public var items: [Item]?
    private(set) public var label: String?
    
    enum CodingKeys: String, CodingKey {
        case label
        case items = "ads"
    }
    
}
