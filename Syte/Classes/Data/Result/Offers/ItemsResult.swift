//
//  ItemsResult.swift
//  Syte
//
//  Created by Artur Tarasenko on 31.08.2021.
//

import Foundation

public class ItemsResult: Codable, ReflectedStringConvertible {
    
    private(set) var items: [Item]?
    private(set) var currencySymbol: String?
    private(set) var currencyTla: String?
    
    enum CodingKeys: String, CodingKey {
        case items = "ads"
        case currencySymbol = "currency_symbol"
        case currencyTla = "currency_tla"
    }
    
}
