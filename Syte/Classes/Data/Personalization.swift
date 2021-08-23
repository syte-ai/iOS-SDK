//
//  Personalization.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

public class Personalization {
    
    private var syteUrlReferer = "mobile_sdk"
    private var limit: Int = 7
    private var modelVersion = "A"
    private var fieldsToReturn: RecommendationReturnField = .all
    
    public init() {}
    
    public func setFieldsToReturn(fieldsToReturn: RecommendationReturnField) {
        self.fieldsToReturn = fieldsToReturn
    }
    
    public func getFieldsToReturn() -> RecommendationReturnField {
        return fieldsToReturn
    }
    
    public func setSyteUrlReferer(syteUrlReferer: String) {
        self.syteUrlReferer = syteUrlReferer
    }
    
    public func getSyteUrlReferer() -> String {
        return syteUrlReferer
    }
    
    public func setLimit(limit: Int) {
        self.limit = limit
    }
    
    public func getLimit() -> Int {
        return limit
    }
    
    public func setModelVersion(modelVersion: String) {
        self.modelVersion = modelVersion
    }
    
    public func getModelVersion() -> String {
        return modelVersion
    }
    
}
