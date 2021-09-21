//
//  ShopTheLookResult.swift
//  Syte
//
//  Created by Artur Tarasenko on 17.09.2021.
//

import Foundation

public class ShopTheLookResult: Codable, ReflectedStringConvertible {
    
    private(set) public var items: [ShopTheLookResponseItem]?
    private(set) public var fallback: String?
    public var sytePlatformSettings: SytePlatformSettings?
    
    enum CodingKeys: String, CodingKey {
        case fallback
        case items = "response"
    }
    
    public func getItemsForAllLabels() -> [Item] {
        return getItemsForAllLabels(forceZip: sytePlatformSettings?.data?.products?.syteapp?.features?.shopTheLook?.zip ?? false)
    }
    
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
        
        for i in 0..<maxIdx {
            for item in items {
                if let values = item.items, values.count > i {
                    itemList.append(values[i])
                }
            }
        }
        
        return itemList
    }
    
}
