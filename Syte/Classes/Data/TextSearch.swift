//
//  TextSearch.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

public class TextSearch {
    
    private var query: String = ""
    private var lang: String = ""
    private var filters = [String]()
    private var from: Int = 0
    private var size: Int = 20
    private var textSearchSorting: TextSearchSorting = .default
    
    public init(query: String, lang: String) {
        self.query = query
        self.lang = lang
    }
    
    public func setQuery(_ query: String) {
        self.query = query
    }
    
    public func getQuery() -> String {
        return query
    }
    
    public func setLang(_ lang: String) {
        self.lang = lang
    }
    
    public func getLang() -> String {
        return lang
    }
    
    public func addFilters(filters: [String]) {
        self.filters.append(contentsOf: filters)
    }
    
    public func addFilter(filter: String) {
        filters.append(filter)
    }
    
    public func getFilters() -> [String] {
        return filters
    }
    
    public func setFrom(_ value: Int) {
        from = value
    }
    
    public func getFrom() -> Int {
        return from
    }
    
    public func setSize(_ value: Int) {
        size = value
    }
    
    public func getSize() -> Int {
        return size
    }
    
    public func setSorting(_ value: TextSearchSorting) {
        textSearchSorting = value
    }
    
    public func getSorting() -> TextSearchSorting {
        return textSearchSorting
    }
    
}
