//
//  ShopTheLookSettings.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class ShopTheLookSettings: Codable {
    
    public var zip: Bool?
    public var getOriginalBound: Bool?
    public var shouldNotFetchSimilars: Bool?
    public var active: Bool?
    public var shouldNotUseFallbackImages: Bool?
    
}
