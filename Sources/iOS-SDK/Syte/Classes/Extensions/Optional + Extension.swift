//
//  Optional + Extension.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

extension Optional {
    
    func or(_ other: Optional) -> Optional {
        switch self {
        case .none:
            return other
        case .some:
            return self
        }
    }
    
    func resolve(with error: @autoclosure () -> Error) throws -> Wrapped {
        switch self {
        case .none:
            throw error()
        case .some(let wrapped):
            return wrapped
        }
    }
    
}
