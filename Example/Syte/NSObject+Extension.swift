//
//  NSObject+Extension.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 13.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

extension NSObject {
    
    class var className: String {
        return String(describing: self)
    }
    
}
