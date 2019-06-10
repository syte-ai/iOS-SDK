//
//  Logger.swift
//  Syte
//
//  Created by David Jinely on 6/2/19.
//  Copyright © 2019 David Jinely. All rights reserved.
//

import Foundation

struct Logger {
    static var isDebugging = false
    static func start(url: String) {
        if isDebugging {
            print("FETCH STARTED: \(url)")
        }
    }
    
    static func succeed(response: Any?) {
        if isDebugging {
            print("FETCH SUCCEEDED: \(response ?? "")")
        }
    }
    
    static func fail(error: Any?) {
        if isDebugging {
            print("FETCH FAILED: \(error ?? "")")
        }
    }
    
}
