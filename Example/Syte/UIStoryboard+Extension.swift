//
//  UIStoryboard+Extension.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 13.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

// swiftlint:disable force_cast

extension UIStoryboard {
    
    class var nameReplaced: String {
        return self.className.replacingOccurrences(of: "Storyboard", with: "")
    }
    
    class var instance: UIStoryboard {
        return UIStoryboard(name: self.nameReplaced, bundle: nil)
    }
    
    func instantiate<T: UIViewController>(customID: String? = nil) -> T {
        return self.instantiateViewController(withIdentifier: customID ?? T.className) as! T
    }
    
    class func instantiate<T: UIViewController>(customID: String? = nil) -> T {
        return self.instance.instantiate(customID: customID)
    }
    
}

// swiftlint:enable force_cast
