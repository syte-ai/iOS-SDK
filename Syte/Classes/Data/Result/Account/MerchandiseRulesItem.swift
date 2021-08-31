//
//  MerchandiseRulesItem.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class MerchandiseRulesItem: Codable, ReflectedStringConvertible {
    
    public var subRules: [SubRulesItem]?
    public var product: String?
    public var metadata: Metadata?
    public var searchCondition: SearchCondition?
    public var name: String?
    public var active: Bool?
    public var weight: Int?
    public var action: String?
    public var id: String?
    public var sourceCondition: [SourceConditionItem]?
    
}
