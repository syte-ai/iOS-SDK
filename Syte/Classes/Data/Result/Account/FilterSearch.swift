//
//  FilterSearch.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class FilterSearch: Codable, ReflectedStringConvertible {
    
    public var itemsPerPage: Int?
    public var active: Bool?
    public var customCSS: String?

}
