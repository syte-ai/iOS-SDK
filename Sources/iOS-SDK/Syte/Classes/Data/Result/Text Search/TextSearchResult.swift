//
//  TextSearchResult.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.09.2021.
//

import Foundation

public class TextSearchResult: Codable, ReflectedStringConvertible {
    
    private(set) public var result: ResultTextSearch?
    private(set) public var error: String?
    
}
