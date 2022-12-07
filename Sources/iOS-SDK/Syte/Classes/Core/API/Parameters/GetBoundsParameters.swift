//
//  GetBoundsParameters.swift
//  Alamofire
//
//  Created by Artur Tarasenko on 17.09.2021.
//

import Foundation

struct GetBoundsParameters {
    
    let accountId: String
    let signature: String
    let userId: String?
    let sessionId: String?
    let syteAppRef: String
    let locale: String
    let sku: String?
    let imageUrl: String
    let sessionSkus: String?
    let options: [String: String]
    
    func dictionaryRepresentation() -> [String: Any] {
        let parametersWithOptionals: [String: Any?] = [
            "account_id": accountId,
            "sig": signature,
            "syte_uuid": userId,
            "session_id": sessionId,
            "syte_app_ref": syteAppRef,
            "locale": locale,
            "sku": sku,
            "imageUrl": imageUrl,
            "session_skus": sessionSkus
        ]
        var parameters: [String: Any] = parametersWithOptionals.compactMapValues({$0})
        parameters.merge(options) { (current, _) in current }
        return parameters
    }
    
}
