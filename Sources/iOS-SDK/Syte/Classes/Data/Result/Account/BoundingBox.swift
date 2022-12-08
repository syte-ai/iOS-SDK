//
//  BoundingBox.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class BoundingBox: Codable, ReflectedStringConvertible {
    
    public var offerNavBehaviourDesktop: String?
    public var filtersMobileLayoutV2: Bool?
    public var active: Bool?
    public var offerNavBehaviourMobile: String?
    public var inspoGalleryImagesSkus: [String]?
    public var inspoGalleryImages: [String]?
    public var filters: Filters?
    public var desktopTheme: String?
    public var imageSelector: String?
    public var cropper: Cropper?
    public var numOfAds: Int?
    public var decoratorType: String?
    public var requireApproval: Bool?
    public var showQuickView: Bool?
    public var theme: String?

}
