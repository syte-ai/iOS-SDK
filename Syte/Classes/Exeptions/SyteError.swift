//
//  SyteError.swift
//  Syte
//
//  Created by Artur Tarasenko on 21.08.2021.
//

import Foundation

enum SyteError: Error {
    
    case wrongInput(message: String)
    case initializationFailed(message: String)
    case generalError(message: String)
    
    var localizedDescription: String {
        switch self {
        case .generalError(let message), .wrongInput(let message), .initializationFailed(let message):
            return message
        }
    }
    
}

extension SyteError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .generalError(let message), .wrongInput(let message), .initializationFailed(let message):
            return NSLocalizedString(message, comment: "")
        }
    }
}
