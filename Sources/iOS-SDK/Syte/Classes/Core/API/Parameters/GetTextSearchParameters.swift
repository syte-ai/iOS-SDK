//
//  GetTextSearchParameters.swift
//  Syte
//
//  Created by Artur Tarasenko on 21.09.2021.
//

import Foundation

struct GetTextSearchParameters {
    
    let accountId: String
    let lang: String
    let signature: String
    let query: String
    let filters: String?
    let from: Int
    let size: Int
    let sorting: String?
    let options: [String: String]
    
    func dictionaryRepresentation() -> [String: Any] {
        let parametersWithOptionals: [String: Any?] = [
            "account_id": accountId,
            "lang": lang,
            "sig": signature,
            "query": query,
            "filters": filters,
            "from": from,
            "size": size,
            "sorting": sorting
        ]
        var parameters: [String: Any] = parametersWithOptionals.compactMapValues({$0})
        
        parameters.merge(options) { (current, _) in current }
        return parameters
    }
    
}
