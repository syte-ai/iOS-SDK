//
//  BaseProvider.swift
//  Syte
//
//  Created by Artur Tarasenko on 18.08.2021.
//  Copyright © 2021 Syte.ai. All rights reserved.
//

import Foundation
import Moya

protocol BaseProvider {}

extension BaseProvider {
    
    var baseURL: URL {
        URL(string: "https://cdn.syteapi.com")!
    }
    
    var path: String {
        ""
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Task {
        .requestPlain
    }
    
    var sampleData: Data {
        Data()
    }
    
    var headers: [String: String]? {
        ["Content-type": "application/json"]
    }
    
    var authorizationType: AuthorizationType {
        .basic
    }
    
}
