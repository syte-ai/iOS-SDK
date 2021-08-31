//
//  SyteApp.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class SyteApp: Codable, ReflectedStringConvertible {
    
    private var features: Features?
    private var preloadFonts: Bool?
    private var showBanner: Bool?
    private var requireApproval: Bool?
    private var customBrand: String?
    private var catalog: String?
    private var theme: Theme?
    private var originalUrl: String?
    private var shouldReportPageViews: Bool?
    private var url: String?
    private var enabled: Bool?
    
}
