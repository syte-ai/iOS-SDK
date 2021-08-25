//
//  WeightsItem.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class WeightsItem: Codable {
    
    public var field: String?
    public var weight: Int?
    public var displayName: String?
    public var enabled: Bool?
    public var order: String?
    
    enum CodingKeys: String, CodingKey {
        case field, weight, enabled, order
        case displayName = "display_name"
    }
    
}
