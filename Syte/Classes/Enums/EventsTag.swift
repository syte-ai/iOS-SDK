//
//  EventsTag.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

public enum EventsTag: String {
    
    case camera = "camera"
    case ecommerce = "ecommerce"
    case discoveryButton = "discovery_button"
    case similarItems = "similar_items"
    case syte_ios_sdk = "syte_ios_sdk"
    case textSearch = "text_search"
    case shopTheLook = "shop_the_look"
    
    public func getName() -> String {
        return self.rawValue
    }
    
}
