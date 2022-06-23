//
//  ExifProvider.swift
//  Syte
//
//  Created by Artur Tarasenko on 07.09.2021.
//

import Moya

enum ExifProvider: BaseProvider {
    case removeTags(accountId: String, signature: String, imagePayload: Data)
}

extension ExifProvider: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        URL(string: "https://imagemod.syteapi.com/")!
    }
    
    var path: String {
        switch self {
        case .removeTags:
            return "align"
        }
    }
    
    var method: Moya.Method {
        .put
    }
    
    var task: Task {
        switch self {
        case .removeTags(let accountId, let signature, let imagePayload):
            let parameters = ["account_id": accountId, "sig": signature].compactMapValues({$0})
            return .requestCompositeData(bodyData: imagePayload, urlParameters: parameters)
        }
    }
    
    var authorizationType: AuthorizationType? {
        .bearer
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-type": "application/json"]
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
}
