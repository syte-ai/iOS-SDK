//
//  Utils.swift
//  Syte
//
//  Created by Artur Tarasenko on 31.08.2021.
//

import Foundation

class Utils {
    
    public static func viewedProductsString(viewedProducts: Set<String>) -> String? {
        guard viewedProducts.isEmpty == false else { return nil }
        return viewedProducts.joined(separator: ",")
    }
    
}
