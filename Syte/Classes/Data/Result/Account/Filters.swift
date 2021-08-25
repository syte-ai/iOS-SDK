//
//  Filters.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class Filters: Codable {
    
    public var gender: Gender?
    public var size: Size?
    public var price: Price?
    public var custom: [String]?
    public var brand: Brand?
    public var colors: Colors?
    public var categoryFilters: [String]?
    public var allowedFilters: [String]?

}
