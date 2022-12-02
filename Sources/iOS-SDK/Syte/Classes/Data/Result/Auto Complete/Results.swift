//
//  Results.swift
//  Syte
//
//  Created by Artur Tarasenko on 22.09.2021.
//

import Foundation

public class Results: Codable, ReflectedStringConvertible {
    
    private(set) public var allResults: String?
    private(set) public var suggestedItems: [SuggestedItem]?
    private(set) public var suggestedCategories: [String]?
    private(set) public var suggestedSearchTerms: [SuggestedSearchTermsItem]?
    private(set) public var label: String?
    private(set) public var b0: [Double]?
    private(set) public var b1: [Double]?
    
}
