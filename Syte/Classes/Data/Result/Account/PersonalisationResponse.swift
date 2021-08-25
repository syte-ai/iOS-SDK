//
//  PersonalisationResponse.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class PersonalisationResponse: Codable {

    public var features: Features?
    public var modelTrainHourInterval: Int?

}
