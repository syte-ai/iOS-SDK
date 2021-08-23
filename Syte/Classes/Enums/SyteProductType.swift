//
//  SyteProductType.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

public enum SyteProductType: String {
    
    case camera = "camera"
    case discoveryButton = "discovery_button"
    
    public func getName() -> String {
        return self.rawValue
    }
    
}
