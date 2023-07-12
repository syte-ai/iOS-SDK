//
//  ResultTextSearch.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.09.2021.
//

import Foundation

public class ResultTextSearch: Codable, ReflectedStringConvertible {
    
    private(set) public var hits: [HitsItem]?
    private(set) public var total: Int?
    private(set) public var recognizedTagging: RecognizedTagging?
    private(set) public var aggregations: Aggregations?
    private(set) public var exactCount: Int?
    
}
