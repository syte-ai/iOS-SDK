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
    
    public static func getImageScale(settings: SytePlatformSettings?) -> ImageProcessor.Scale {
        guard let settings = settings else { return .medium }
        let imageScale = settings.data?.products?.syteapp?.features?.cameraHandler?.photoReductionSize ?? ""
        var scale: ImageProcessor.Scale = .small
        
        switch imageScale.lowercased() {
        case "small":
            scale = .small
        case "medium":
            scale = .medium
        case "large":
            scale = .large
        default:
            scale = .medium
        }
        return scale
    }
    
}
