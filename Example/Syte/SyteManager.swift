//
//  SyteManager.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 10.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Syte

class SyteMaganer {
    
    static let shared = SyteMaganer()
    
    private let syte = InitSyte()
    
    private init() {}
    
    func startSession(accountId: String, signature: String) {
        
    }
    
}
