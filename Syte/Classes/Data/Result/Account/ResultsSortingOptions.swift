//
//  ResultsSortingOptions.swift
//  Syte
//
//  Created by Artur Tarasenko on 24.08.2021.
//

import Foundation

public class ResultsSortingOptions: Codable, ReflectedStringConvertible {
    
    public var viewsCount: ViewsCount?
    public var relevance: Relevance?
    public var bestSellers: BestSellers?
    
    enum CodingKeys: String, CodingKey {
        case relevance, bestSellers
        case viewsCount = "views_count"
    }
    
}
