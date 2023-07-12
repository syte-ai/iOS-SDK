//
//  SuggestedItem.swift
//  Syte
//
//  Created by Artur Tarasenko on 22.09.2021.
//

import Foundation

public class SuggestedItem: Codable, ReflectedStringConvertible {
    
    private(set) public var offer: String?
    private(set) public var floatPrice: String?
    private(set) public var originalPrice: String?
    private(set) public var price: String?
    private(set) public var imageUrl: String?
    private(set) public var description: String?
    private(set) public var floatOriginalPrice: String?
    private(set) public var id: String?
    private(set) public var title: String?
    
}
