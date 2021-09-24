//
//  Utils.swift
//  Syte
//
//  Created by Artur Tarasenko on 31.08.2021.
//

import Foundation

class Utils {
    
    static func viewedProductsString(viewedProducts: Set<String>) -> String? {
        guard viewedProducts.isEmpty == false else { return nil }
        return viewedProducts.joined(separator: ",")
    }
    
    static func getImageScale(settings: SytePlatformSettings?) -> ImageProcessor.Scale {
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
    
    static func viewedProductsJSONArray(viewedProducts: Set<String>) -> String? {
        guard viewedProducts.isEmpty == false else { return nil }
        var string = "["
        for sku in viewedProducts {
            string += "\""
            string += sku
            string += "\""
            string += ","
        }
        string.removeLast()
        string += "]"
        return string
    }
    
    static func viewedProductsJSONArray(sku: String?) -> String? {
        guard let sku = sku else { return nil }
        return "[\(sku)]"
        
    }
    
    static func textSearchTermsString(terms: [String]) -> String? {
        guard terms.isEmpty == false else { return nil }
        return terms.joined(separator: ",")
    }
    
    static func generateFiltersString(filters: TextSearchFilters) -> String? {
        guard !filters.isEmpty else { return nil }
        var string = "{"
        for filter in filters {
            string += "\"\(filter.key)\":["
            for filterValue in filter.value {
                string += "\"\(filterValue)\","
            }
            string.removeLast()
            string += "]"
        }
        string.removeLast()
        string += "}"
        return string
    }
    
}
