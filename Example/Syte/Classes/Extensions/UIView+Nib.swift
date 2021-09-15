//
//  UIView+Nib.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 13.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

public func instancetype<T>(object: Any?) -> T? {
    return object as? T
}

extension UIView {
    
    static var reuseIdentifier: String {
        return self.className
    }
    
    static var nib: UINib {
        return UINib(nibName: self.className, bundle: nil)
    }
    
    class func fromXib(_ name: String? = nil) -> Self? {
        return instancetype(object: Bundle.main.loadNibNamed(name ?? self.className, owner: nil, options: nil)?.last)
    }
    
}
