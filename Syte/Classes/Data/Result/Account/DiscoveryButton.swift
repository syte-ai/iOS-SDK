//
//  DiscoveryButton.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class DiscoveryButton: Codable, ReflectedStringConvertible {
    
    public var css: String?
    public var active: Bool?
    public var enableDesktopSort: Bool?
    public var cropper: Cropper?
    public var enableMobileFilters: Bool?
    public var overrideImageUrl: OverrideImageUrl?
    public var enableDesktopFilters: Bool?
    public var icon2xUrl: String?
    public var showAdditionalPersonalisedResults: Bool?
    public var elementSelector: String?
    public var enableMobileSort: Bool?
    public var selector: String?
    public var iconUrl: String?
    public var showPersonalResults: Bool?
    public var selector2x: String?
    
}
