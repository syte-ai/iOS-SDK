//
//  EventsProvider.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Moya

enum EventsProvider: BaseProvider {
    case fireEvent(tags: String,
                   name: String,
                   accountId: String,
                   signature: String,
                   sessionId: String,
                   userId: String,
                   syteUrlReferer: String,
                   body: Data)
}

extension EventsProvider: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        return URL(string: "https://syteapi.com")!
    }
    
    var path: String {
        switch self {
        case .fireEvent:
            return "/et"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case .fireEvent(let tags, let name, let accountId, let signature, let sessionId, let userId, let syteUrlReferer, let body):
            let parameters = [
                "tags": tags,
                "name": name,
                "account_id": accountId,
                "sig": signature,
                "session_id": sessionId,
                "syte_uuid": userId,
                "syte_url_referer": syteUrlReferer
            ].compactMapValues({$0})
            return .requestCompositeData(bodyData: body, urlParameters: parameters)
        }
    }
    
    var authorizationType: AuthorizationType? {
        return .bearer
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-type": "application/octet-stream"]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
}
