//
//  GetSkuConfig.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class GetSkuConfig: Codable {
    
    public var skuProvidersOrder: [String]?
    public var shouldReportMissingSkus: Bool?
    public var functionConfig: String?
    
}
