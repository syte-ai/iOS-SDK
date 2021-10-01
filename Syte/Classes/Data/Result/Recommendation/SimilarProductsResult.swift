//
//  SimilarProductsResult.swift
//  Syte
//
//  Created by Artur Tarasenko on 17.09.2021.
//

import Foundation

/**
 A class that represents the result for 'Similars' call
 */
public class SimilarProductsResult: Codable, ReflectedStringConvertible {
    
    private(set) public var data: [Item]?
    
    enum CodingKeys: String, CodingKey {
        case data = "response"
    }
    
}
