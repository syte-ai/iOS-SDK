//
//  CameraHandler.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class CameraHandler: Codable {
    
    public var enableMobileFilters: Bool?
    public var enablePersonalisationTourImages: Bool?
    public var enableDesktopFilters: Bool?
    public var inMaintenance: Bool?
    public var mobileTourScreen: MobileTourScreen?
    public var active: Bool?
    public var enableMobileSort: Bool?
    public var enableDesktopSort: Bool?
    public var photoReductionSize: String?
    
}
