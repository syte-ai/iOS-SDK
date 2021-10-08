//
//  ShopTheLookResult.swift
//  Syte
//
//  Created by Artur Tarasenko on 17.09.2021.
//

import Foundation

/**
 A class that represents the result for 'Shop the look' call
 */
public class ShopTheLookResult: Codable, ReflectedStringConvertible {
    
    /// Array of ShopTheLookResponseItem
    private(set) public var items: [ShopTheLookResponseItem]?
    
    /// Fallback value
    private(set) public var fallback: String?
    
    enum CodingKeys: String, CodingKey {
        case fallback
        case items = "response"
    }
    
    /**
     Get list of all retrieved items. If zip is true, the items will be shuffled.
     - Returns: [Items]
     */
    public func getItemsForAllLabels() -> [Item] {
        return getItemsForAllLabels(forceZip: false)
    }
    
    /**
     Get list of all retrieved items. If zip is true, the items will be shuffled.
     - Parameter forceZip: true to shuffle items
     - Returns: [Items]
     */
    public func getItemsForAllLabels(forceZip: Bool) -> [Item] {
        guard let items = items else { return [] }
        var itemList = [Item]()
        
        guard forceZip else {
            for item in items {
                itemList.append(contentsOf: item.items ?? [])
            }
            return itemList
        }
        
        var maxIdx = 0
        
        for item in items {
            guard let values = item.items else { continue }
            maxIdx = values.count - 1
        }
        
        for i in 0...maxIdx {
            for item in items {
                if let values = item.items, values.count > i {
                    itemList.append(values[i])
                }
            }
        }
        
        return itemList
    }
    
}
