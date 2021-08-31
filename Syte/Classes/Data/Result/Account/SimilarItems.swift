//
//  SimilarItems.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class SimilarItems: Codable, ReflectedStringConvertible {
    
    public var offerNavBehaviourDesktop: String?
    public var active: Bool?
    public var offerNavBehaviourMobile: String?
    public var shouldNotUseFallbackImages: Bool?
    
}
