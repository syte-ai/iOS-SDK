//
//  SyteProvider.swift
//  Syte
//
//  Created by Artur Tarasenko on 21.08.2021.
//

import Moya

enum SyteProvider: BaseProvider {
    
    case getSettings(accountId: String)
    
    case getBounds(parameters: GetBoundsParameters)
    
    case getOffers(parameters: GetOffersParameters)
    
    case getSimilars(parameters: GetSimilarsParameters)
    
    case getShopTheLook(parameters: GetShopTheLookParameters)
    
    case getPersonalization(parameters: GetPersonalizationParameters)
    
    case getPopularSearch(parameters: GetPopularSearchParameters)
    
    case getTextSearch(parameters: GetTextSearchParameters)
    
    case getAutoComplete(parameters: GetAutoCompleteParameters)
    
}

extension SyteProvider: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        let base = URL(string: "https://cdn.syteapi.com")!
        switch self {
        case .getOffers(let parameters):
            return URL(string: parameters.offersUrl) ?? base
        default:
            return base
        }
        
    }
    
    var path: String {
        switch self {
        case .getSettings(let accountId):
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
        case .getPopularSearch(let parameters):
            return "/search/\(parameters.accountId)/popularSearches"
        case .getTextSearch(let parameters):
            return "/search/\(parameters.accountId)/items"
        case .getAutoComplete(let parameters):
            return "/search/\(parameters.accountId)/autocomplete"
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
        case .getBounds(let parameters):
            return .requestParameters(parameters: parameters.dictionaryRepresentation(), encoding: URLEncoding.queryString)
        case .getOffers(let parameters):
            return .requestParameters(parameters: parameters.dictionaryRepresentation(), encoding: URLEncoding.queryString)
        case .getSimilars(let parameters):
            return .requestParameters(parameters: parameters.dictionaryRepresentation(), encoding: URLEncoding.queryString)
        case .getShopTheLook(let parameters):
            return .requestParameters(parameters: parameters.dictionaryRepresentation(), encoding: URLEncoding.queryString)
        case .getPersonalization(let parameters):
            return .requestCompositeData(bodyData: parameters.body, urlParameters: parameters.dictionaryRepresentation())
        case .getPopularSearch(let parameters):
            return .requestParameters(parameters: parameters.dictionaryRepresentation(), encoding: URLEncoding.queryString)
        case .getTextSearch(let parameters):
            return .requestParameters(parameters: parameters.dictionaryRepresentation(), encoding: URLEncoding.queryString)
        case .getAutoComplete(let parameters):
            return .requestParameters(parameters: parameters.dictionaryRepresentation(), encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var authorizationType: AuthorizationType? {
        return .bearer
    }
    
    var headers: [String: String]? {
        switch self {
        case .getPersonalization:
            return ["Content-type": "text/plain"]
        default:
            return ["Content-type": "application/json"]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
}
