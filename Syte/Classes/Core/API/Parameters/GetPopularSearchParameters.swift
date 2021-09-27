//
//  GetPopularSearchParameters.swift
//  Syte
//
//  Created by Artur Tarasenko on 21.09.2021.
//

import Foundation

struct GetPopularSearchParameters {
    
    let accountId: String
    let signature: String
    let lang: String
    
    func dictionaryRepresentation() -> [String: Any] {
        let parametersWithOptionals: [String: Any?] = [
            "account_id": accountId,
            "sig": signature,
            "lang": lang
        ]
        let parameters: [String: Any] = parametersWithOptionals.compactMapValues({$0})
        return parameters
    }
    
}
