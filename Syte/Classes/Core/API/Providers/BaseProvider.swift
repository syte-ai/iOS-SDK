//
//  BaseProvider.swift
//  Syte
//
//  Created by Artur Tarasenko on 18.08.2021.
//  Copyright © 2021 Syte.ai. All rights reserved.
//

import Moya

protocol BaseProvider {}

extension BaseProvider {
    
    var baseURL: URL {
        guard let url = URL(string: "https://cdn.syteapi.com") else {
            fatalError("Base URL could not be configured.")
        }
        
        return url
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var authorizationType: AuthorizationType {
        return .basic
    }
    
}
