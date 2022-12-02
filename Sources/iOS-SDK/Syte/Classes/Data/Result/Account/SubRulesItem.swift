//
//  SubRulesItem.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class SubRulesItem: Codable, ReflectedStringConvertible {
    
    public var field: String?
    public var values: [JSONValue?]?
    public var platformSubType: String?
    public var subType: String?
    public var type: String?
    public var enabled: Bool?
    
}
