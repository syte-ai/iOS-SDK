//
//  PlatformSettingsData.swift
//  Syte
//
//  Created by Artur Tarasenko on 24.08.2021.
//

import Foundation

public class PlatformSettingsData: Codable, ReflectedStringConvertible {
    
    public var checkFeedHealth: Bool?
    public var isProduction: Bool?
    public var crossProductFeatures: CrossProductFeatures?
    public var version: Int?
    public var enabled: Bool?
    public var logoUrl: String?
    public var products: Products?
    public var accountId: Int?
    public var feedsDefaults: FeedsDefaults?
    public var domain: String?
    public var feeds: Feeds?
    public var api: Api?
    public var ecommercePixel: Bool?
    
}
