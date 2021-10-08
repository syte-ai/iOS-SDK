//
//  SyteResult.swift
//  Syte
//
//  Created by Artur Tarasenko on 18.08.2021.
//  Copyright © 2021 Syte.ai. All rights reserved.
//

import Foundation

/**
 Generic wrapper for the API result.
 */
public class SyteResult<T> {
    
    /// Data returned by the API.
    public var data: T?
    
    /// Response result code.
    public var resultCode = -1
    
    /// Indicates whether the response is successful.
    public var isSuccessful = false
    
    /// Holds the error message if there is any.
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
    
    func mapData<V>(_ closure: (SyteResult<T>) -> V?) -> SyteResult<V> {
        let result = SyteResult<V>()
        result.resultCode = resultCode
        result.errorMessage = errorMessage
        result.isSuccessful = isSuccessful
        result.data = closure(self)
        
        return result
    }
    
    static var syteNotInilialized: SyteResult<T> {
        let syteResult = SyteResult<T>()
        syteResult.data = nil
        syteResult.errorMessage = "Syte is not initialized."
        return syteResult
    }
    
    static func failureResult<T>(message: String) -> SyteResult<T> {
        let syteResult = SyteResult<T>()
        syteResult.data = nil
        syteResult.errorMessage = message
        
        return syteResult
    }
    
    static func successResult<T>(data: T, code: Int) -> SyteResult<T> {
        let syteResult = SyteResult<T>()
        syteResult.data = data
        syteResult.isSuccessful = true
        syteResult.resultCode = code
        return syteResult
    }
    
}
