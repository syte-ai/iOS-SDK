//
//  Bound.swift
//  Syte
//
//  Created by Artur Tarasenko on 31.08.2021.
//

import Foundation

/**
 Represents Bound entity.
 */
public class Bound: Codable, ReflectedStringConvertible {
    
    // Item Url
    private(set) public var offersUrl: String?
    
    // Gender
    private(set) public var gender: String?
    
    // Catalog
    private(set) public var catalog: String?
    
    // Bound center
    private(set) public var center: [Double]?
    
    // Label
    private(set) public var label: String?
    
    // Top left point coordinates
    private(set) public var b0: [Double]?
    
    // Bottom right point coordinates
    private(set) public var b1: [Double]?
    
    enum CodingKeys: String, CodingKey {
        case gender, catalog, center, label, b0, b1
        case offersUrl = "offers"
    }
    
}
