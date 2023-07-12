//
//  EventDiscoveryButtonImpression.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation

/**
 This event should be sent to Syte every time discovery button becomes visible to a user / enters user viewport.
 */
public class EventDiscoveryButtonImpression: BaseSyteEvent {
    
    public init(pageName: String) {
        super.init(name: "fe_discovery_button_impression", syteUrlReferer: pageName, tag: .discoveryButton)
    }
    
    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
    
}
