//
//  BucketsItem.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.09.2021.
//

import Foundation

public class BucketsItem: Codable, ReflectedStringConvertible {
    
    private(set) public var key: String?
    private(set) public var docCount: Int?
    private(set) public var displayName: String?
    
    enum CodingKeys: String, CodingKey {
        case key
        case docCount = "doc_count"
        case displayName = "display_name"
    }
    
}
