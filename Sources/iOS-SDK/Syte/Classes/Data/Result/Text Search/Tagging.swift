//
//  Tagging.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.09.2021.
//

import Foundation

public class Tagging: Codable, ReflectedStringConvertible {
    
    private(set) public var brand: [String]?
    private(set) public var color: [String]?
    private(set) public var cat: [String]?
    private(set) public var neckline: [String]?
    private(set) public var length: [String]?
    private(set) public var sleeve: [String]?
    private(set) public var pattern: [String]?
    private(set) public var type: [String]?
    private(set) public var closure: [String]?
    private(set) public var style: [String]?
    private(set) public var look: [String]?
    private(set) public var texture: [String]?
    private(set) public var detail: [String]?
    private(set) public var rise: [String]?
    private(set) public var shape: [String]?
    private(set) public var height: [String]?
    private(set) public var lapelStyle: [String]?
    private(set) public var trim: [String]?
    
    enum CodingKeys: String, CodingKey {
        case brand = "Brand"
        case color = "Color"
        case cat = "Cat"
        case neckline = "Neckline"
        case length = "Length"
        case sleeve = "Sleeve"
        case pattern = "Pattern"
        case type = "Type"
        case closure = "Closure"
        case style = "Style"
        case look = "Look"
        case texture = "Texture"
        case detail = "Detail"
        case rise = "Rise"
        case shape = "Shape"
        case height = "Height"
        case lapelStyle = "LapelStyle"
        case trim = "Trim"
    }
    
}
