//
//  Currency.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class Currency: Codable, ReflectedStringConvertible {
    
    public var precision: Int?
    public var format: String?
    public var decimal: String?
    public var thousands: String?
    
}
