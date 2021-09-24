//
//  Straps.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.09.2021.
//

import Foundation

public class Straps: Codable, ReflectedStringConvertible {
    
    private(set) public var docCountErrorUpperBound: Int?
    private(set) public var sumOtherDocCount: Int?
    private(set) public var buckets: [JSONValue?]?
    private(set) public var displayName: String?
    private(set) public var order: Int?
    
    enum CodingKeys: String, CodingKey {
        case buckets, order
        case docCountErrorUpperBound = "doc_count_error_upper_bound"
        case sumOtherDocCount = "sum_other_doc_count"
        case displayName = "display_name"
    }
    
}
