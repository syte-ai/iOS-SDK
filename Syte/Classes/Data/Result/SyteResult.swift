//
//  SyteResult.swift
//  Syte
//
//  Created by Artur Tarasenko on 18.08.2021.
//  Copyright © 2021 Syte.ai. All rights reserved.
//

import Foundation

public class SyteResult<T> {
    
    public var data: T?
    public var resultCode = -1
    public var isSuccessful = false
    public var errorMessage: String?
    
}

extension SyteResult where T == Bool {
    
    static var successResult: SyteResult<Bool> {
        let syteResult = SyteResult<Bool>()
        syteResult.data = true

        return syteResult
    }
    
    static func failureResult(message: String) -> SyteResult<Bool> {
        let syteResult = SyteResult<Bool>()
        syteResult.data = false
        syteResult.errorMessage = message

        return syteResult
    }
    
}

extension SyteResult {
    
    static func failureResult<T>(message: String) -> SyteResult<T> {
        let syteResult = SyteResult<T>()
        syteResult.data = nil
        syteResult.errorMessage = message

        return syteResult
    }
    
}
