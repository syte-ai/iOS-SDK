//
//  TextSearch.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

public typealias TextSearchFilters = [String: [String]]

/**
 Class that is used to configure the Text search.
 */
public class TextSearch {
    
    // Search query
    public var query: String = ""
    
    // Search query language
    public var lang: String = ""
    
    // Filter the results according to the user selection
    // Available filters can be retrieved after the first Text search call.
    public var filters: TextSearchFilters = [:]
    
    // Indicate the page number according to user selection and display results
    public var from: Int = 0
    
    // Page size (number of results per page)
    public var size: Int = 20
    
    // Use this to sort the results according to the user selection. Default is best match according to the ranking strategy set for your account.
    public var textSearchSorting: TextSearchSorting = .default
    
    // You can use options to include custom parameters
    public var options = [String: String]()
    
    public init(query: String, lang: String) {
        self.query = query
        self.lang = lang
    }
    
}
