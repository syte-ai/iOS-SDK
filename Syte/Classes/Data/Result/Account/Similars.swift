//
//  Similars.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class Similars: Codable {
    
    public var useBbTags: Bool?
    
    enum CodingKeys: String, CodingKey {
        case useBbTags = "use_bb_tags"
    }
    
}
