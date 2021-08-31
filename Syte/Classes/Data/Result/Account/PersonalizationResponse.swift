//
//  PersonalizationResponse.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class PersonalizationResponse: Codable, ReflectedStringConvertible {

    public var fallback: Fallback?
    public var modelVersion: String?
    public var active: Bool?
    public var takeSkuFromPageviewEvents: Bool?

    enum CodingKeys: String, CodingKey {
        case fallback, active, takeSkuFromPageviewEvents
        case modelVersion = "model_version"
    }

}
