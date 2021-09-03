//
//  BoundsResult.swift
//  Syte
//
//  Created by Artur Tarasenko on 31.08.2021.
//

import Foundation

public class BoundsResult: Codable, ReflectedStringConvertible {
    
    private(set) var bounds: [Bound]?
    var firstBoundItemsResult: ItemsResult?
    
    enum CodingKeys: String, CodingKey {
        case bounds
    }
    
}
