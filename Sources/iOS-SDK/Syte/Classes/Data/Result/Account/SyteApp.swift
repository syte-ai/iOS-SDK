//
//  SyteApp.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class SyteApp: Codable, ReflectedStringConvertible {
    
    public var features: Features?
    public var preloadFonts: Bool?
    public var showBanner: Bool?
    public var requireApproval: Bool?
    public var customBrand: String?
    public var catalog: String?
    public var theme: Theme?
    public var originalUrl: String?
    public var shouldReportPageViews: Bool?
    public var url: String?
    public var enabled: Bool?
    
}
