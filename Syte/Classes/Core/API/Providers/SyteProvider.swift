//
//  SyteProvider.swift
//  Syte
//
//  Created by Artur Tarasenko on 21.08.2021.
//

import Moya

enum SyteProvider: BaseProvider {
    case initialize(accountId: String)
    case getBounds(accountId: String, signature: String, userId: String?, sessionId: String?, syteAppRef: String, locale: String, catalog: String?, sku: String?, imageUrl: String, sessionSkus: String?, options: [String: String])
    case getOffers(offersUrl: String, crop: String?, forceCats: String?, catalog: String?)
    case getSimilars
    case getShopTheLook
    case getPersonalization
}

extension SyteProvider: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        guard let base = URL(string: "https://cdn.syteapi.com") else {
            fatalError("Base URL could not be configured.")
        }
        switch self {
        case .getOffers(let offersUrl, _, _, _):
            return URL(string: offersUrl) ?? base
        default:
            return base
        }
        
    }
    
    var path: String {
        switch self {
        case .initialize(let accountId):
            return "/accounts/\(accountId)"
        case .getBounds:
            return "/v1.1/offers/bb"
        case .getOffers:
            return ""
        case .getSimilars:
            return "/v1.1/similars"
        case .getShopTheLook:
            return "/v1.1/similars"
        case .getPersonalization:
            return "/v1.1/personalization"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPersonalization:
            return .post
        default:
            return.get
        }
    }
    
    var task: Task {
        switch self {
        case .getBounds(let accountId, let signature, let userId, let sessionId, let syteAppRef,
                        let locale, let catalog, let sku, let imageUrl, let sessionSkus, let options):
            var parameters: [String: Any] = [
                "account_id": accountId,
                "sig": signature,
                "syte_uuid": userId,
                "session_id": sessionId,
                "syte_app_ref": syteAppRef,
                "locale": locale,
                "catalog": catalog,
                "sku": sku,
                "imageUrl": imageUrl,
                "session_skus": sessionSkus
            ].compactMapValues({$0})
            
            parameters.merge(options) { (current, _) in current }
            return .requestParameters(parameters: parameters as [String: Any], encoding: URLEncoding.queryString)
        case .getOffers(_, let crop, let forecast, let catalog):
            let parameters = ["crop": crop, "force_cats": forecast, "catalog": catalog].compactMapValues({$0})
            return .requestParameters(parameters: parameters as [String: Any], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var authorizationType: AuthorizationType {
        return .bearer
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-type": "application/json"]
        }
    }
    
}
