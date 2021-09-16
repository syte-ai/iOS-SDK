//
//  Bound.swift
//  Syte
//
//  Created by Artur Tarasenko on 31.08.2021.
//

import Foundation

public class Bound: Codable, ReflectedStringConvertible {
    
    private(set) public var offersUrl: String?
    private(set) public var gender: String?
    private(set) public var catalog: String?
    private(set) public var center: [Double]?
    private(set) public var label: String?
    private(set) public var b0: [Double]?
    private(set) public var b1: [Double]?
    
    enum CodingKeys: String, CodingKey {
        case gender, catalog, center, label, b0, b1
        case offersUrl = "offers"
    }
    
}
