//
//  Bound.swift
//  Syte
//
//  Created by Artur Tarasenko on 31.08.2021.
//

import Foundation

public class Bound: Codable, ReflectedStringConvertible {
    
    private(set) var offersUrl: String?
    private(set) var gender: String?
    private(set) var catalog: String?
    private(set) var center: [Double]?
    private(set) var label: String?
    private(set) var b0: [Double]?
    private(set) var b1: [Double]?
    
    enum CodingKeys: String, CodingKey {
        case gender, catalog, center, label, b0, b1
        case offersUrl = "offers"
    }
    
}
