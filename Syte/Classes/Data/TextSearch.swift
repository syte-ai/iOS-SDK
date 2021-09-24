//
//  TextSearch.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

public typealias TextSearchFilters = [String: [String]]

public class TextSearch {
    
    public var query: String = ""
    public var lang: String = ""
    public var filters: TextSearchFilters = [:]
    public var from: Int = 0
    public var size: Int = 20
    public var textSearchSorting: TextSearchSorting = .default
    public var options = [String: String]()
    
    public init(query: String, lang: String) {
        self.query = query
        self.lang = lang
    }
    
}
