//
//  AutoCompleteResult.swift
//  Syte
//
//  Created by Artur Tarasenko on 22.09.2021.
//

import Foundation

public class AutoCompleteResult: Codable, ReflectedStringConvertible {
    
    private(set) public var error: JSONValue?
    private(set) public var results: Results?
    
}
