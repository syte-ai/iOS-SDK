//
//  GetAutoCompleteParameters.swift
//  Syte
//
//  Created by Artur Tarasenko on 21.09.2021.
//

import Foundation

struct GetAutoCompleteParameters {
    
    let accountId: String
    let lang: String
    let signature: String
    let query: String
    
    func dictionaryRepresentation() -> [String: Any] {
        let parametersWithOptionals: [String: Any?] = [
            "account_id": accountId,
            "lang": lang,
            "sig": signature,
            "query": query
        ]
        let parameters: [String: Any] = parametersWithOptionals.compactMapValues({$0})
        return parameters
    }
    
}
