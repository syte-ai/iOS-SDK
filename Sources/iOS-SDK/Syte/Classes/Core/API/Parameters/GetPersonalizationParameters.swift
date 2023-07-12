//
//  GetPersonalizationswift
//  Syte
//
//  Created by Artur Tarasenko on 17.09.2021.
//

import Foundation

struct GetPersonalizationParameters {
    
    let accountId: String
    let signature: String
    let syteAppRef: String
    let locale: String
    let fields: String?
    let features: String
    let product: String
    let limit: Int
    let syteUrlReferer: String
    let body: Data
    let options: [String: String]
    
    func dictionaryRepresentation() -> [String: Any] {
        let parametersWithOptionals: [String: Any?] = [
            "account_id": accountId,
            "sig": signature,
            "syte_app_ref": syteAppRef,
            "locale": locale,
            "fields": fields,
            "features": features,
            "syte_product": product,
            "limit": limit,
            "syte_url_referer": syteUrlReferer
        ]
        var parameters: [String: Any] = parametersWithOptionals.compactMapValues({$0})
        
        parameters.merge(options) { (current, _) in current }
        return parameters
    }
    
}
