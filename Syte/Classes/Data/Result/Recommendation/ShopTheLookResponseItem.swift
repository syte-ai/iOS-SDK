//
//  ShopTheLookResponseItem.swift
//  Syte
//
//  Created by Artur Tarasenko on 17.09.2021.
//

import Foundation

/**
 A class that represents the Shop the look result item (label + list of items for this label)
 */
public class ShopTheLookResponseItem: Codable, ReflectedStringConvertible {
    
    /// Array of items
    private(set) public var items: [Item]?
    
    /// Label
    private(set) public var label: String?
    
    enum CodingKeys: String, CodingKey {
        case label
        case items = "ads"
    }
    
}
