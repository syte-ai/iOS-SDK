//
//  ItemsResult.swift
//  Syte
//
//  Created by Artur Tarasenko on 31.08.2021.
//

import Foundation

/**
 A class that represents the return result for the offers requests.
 */
public class ItemsResult: Codable, ReflectedStringConvertible {
    
    /// Array of items
    private(set) public var items: [Item]?
    
    /// Currency symbol
    private(set) public var currencySymbol: String?
    
    /// Currency Tla
    private(set) public var currencyTla: String?
    
    enum CodingKeys: String, CodingKey {
        case items = "ads"
        case currencySymbol = "currency_symbol"
        case currencyTla = "currency_tla"
    }
    
}
