//
//  SearchCondition.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class SearchCondition: Codable, ReflectedStringConvertible {
    
    public var terms: [String]?
    public var enabled: Bool?
    
}
