//
//  V11.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class V11: Codable {
    
    public var personalization: PersonalizationResponse?
    public var features: [String]?
    public var similars: Similars?
    public var flags: [String]?
    public var defaultCurrency: String?
    
}
