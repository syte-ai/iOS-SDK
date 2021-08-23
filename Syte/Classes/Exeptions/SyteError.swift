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
    
}
