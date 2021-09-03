//
//  Personalization.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

public class Personalization {
    
    public var syteUrlReferer = "mobile_sdk"
    public var limit: Int = 7
    public var modelVersion = "A"
    public var fieldsToReturn: RecommendationReturnField = .all
    
    public init() {}
    
}
