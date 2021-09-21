//
//  SimilarProductsResult.swift
//  Syte
//
//  Created by Artur Tarasenko on 17.09.2021.
//

import Foundation

public class SimilarProductsResult: Codable, ReflectedStringConvertible {
    
    private(set) public var data: [Item]?
    
    enum CodingKeys: String, CodingKey {
        case data = "response"
    }
    
}
