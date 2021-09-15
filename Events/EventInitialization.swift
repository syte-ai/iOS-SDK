//
//  EventInitialization.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation

public class EventInitialization: BaseSyteEvent {
    
    public init() {
        super.init(name: "syte_init", syteUrlReferer: "syte_ios_sdk", tag: .syte_ios_sdk)
    }
    
    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    
}
