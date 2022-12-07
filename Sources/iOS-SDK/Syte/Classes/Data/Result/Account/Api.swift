//
//  Api.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class Api: Codable, ReflectedStringConvertible {
    
    public var merchandiseRules: [MerchandiseRulesItem]?
    public var hideMissingLabels: Bool?
    public var rankingStrategy: [RankingStrategyItem]?
    public var allowedDomains: [String]?
    public var v11: V11?
    
    enum CodingKeys: String, CodingKey {
        case merchandiseRules, rankingStrategy
        case hideMissingLabels = "hide_missing_labels"
        case allowedDomains = "allowed_domains"
        case v11 = "v1_1"
    }
    
}
