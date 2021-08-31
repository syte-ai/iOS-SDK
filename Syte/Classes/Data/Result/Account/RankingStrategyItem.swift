//
//  RankingStrategyItem.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class RankingStrategyItem: Codable, ReflectedStringConvertible {
    
    public var product: String?
    public var weights: [WeightsItem]?
    
}
