//
//  Enum + Extensions.swift
//  Syte
//
//  Created by Artur Tarasenko on 26.08.2021.
//

import Foundation

extension RawRepresentable where RawValue == String {
    
    public func getName() -> String {
        return rawValue
    }
    
}
