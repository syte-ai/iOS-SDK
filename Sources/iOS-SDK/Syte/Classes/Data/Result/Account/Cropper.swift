//
//  Cropper.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class Cropper: Codable, ReflectedStringConvertible {
    
    public var forceGeneral: Bool?
    public var feed: String?
    public var forceCats: String?
    public var catalog: String?
    public var showCropBtn: Bool?
    public var disableManualCrop: Bool?
    public var enabled: Bool?
    
    enum CodingKeys: String, CodingKey {
        case forceGeneral, feed, catalog, showCropBtn, disableManualCrop, enabled
        case forceCats = "force_cats"
    }
    
}
