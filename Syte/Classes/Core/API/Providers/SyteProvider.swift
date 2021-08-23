//
//  SyteProvider.swift
//  Syte
//
//  Created by Artur Tarasenko on 21.08.2021.
//

import Moya

enum SyteProvider: BaseProvider {
    case initialize(accountId: String)
    case getBounds
    //    case getOffers
    case getSimilars
    case getShopTheLook
    case getPersonalization
}

extension SyteProvider: TargetType, AccessTokenAuthorizable {
    
    var path: String {
        switch self {
        case .initialize(let accountId):
            return "/accounts/\(accountId)"
        case .getBounds:
            return "/v1.1/offers/bb"
        //        case .getOffers:
        //            return "/"
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

