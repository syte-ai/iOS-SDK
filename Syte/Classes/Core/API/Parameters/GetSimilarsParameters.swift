//
//  GetSimilarsswift
//  Syte
//
//  Created by Artur Tarasenko on 17.09.2021.
//

import Foundation

struct GetSimilarsParameters {
    
    let accountId: String
    let signature: String
    let userId: String?
    let sessionId: String?
    let syteAppRef: String
    let locale: String
    let fields: String?
    let sku: String?
    let features: String
    let product: String
    let sessionSkus: String?
    let limit: Int
    let syteUrlReferer: String
    let imageUrl: String
    let options: [String: String]
    
    func dictionaryRepresentation() -> [String: Any] {
        let parametersWithOptionals: [String: Any?] = [
            "account_id": accountId,
            "sig": signature,
            "syte_uuid": userId,
            "session_id": sessionId,
            "syte_app_ref": syteAppRef,
            "locale": locale,
            "fields": fields,
            "q": sku,
            "features": features,
            "syte_product": product,
            "session_skus": sessionSkus,
            "limit": limit,
            "syte_url_referer": syteUrlReferer,
            "imageUrl": imageUrl
        ]
        var parameters: [String: Any] = parametersWithOptionals.compactMapValues({$0})
        
        parameters.merge(options) { (current, _) in current }
        return parameters
    }
    
}
