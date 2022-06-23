//
//  EventBBShowLayout.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation

/**
 This event should be sent to Syte every time a Bounding Boxes layout is visible for user after fetching bounds for an image
 */
public class EventBBShowLayout: BaseSyteEvent {
    
    // Url of image used
    private let imageUrl: String
    
    // the number of bounds returned from bounds request
    private let numOfBBs: Int
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case numOfBBs = "num_of_bbs"
    }
    
    public init(imageUrl: String, numOfBBs: Int, pageName: String) {
        self.imageUrl = imageUrl
        self.numOfBBs = numOfBBs
        
        super.init(name: "fe_bb_show_layout", syteUrlReferer: pageName, tag: .camera)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        numOfBBs = try container.decode(Int.self, forKey: .numOfBBs)
        
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(numOfBBs, forKey: .numOfBBs)
        
        try super.encode(to: encoder)
    }
    
    override public func getRequestBodyString() -> String {
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(self)
        let json = String(data: jsonData ?? Data(), encoding: String.Encoding.utf8)
        
        return json ?? ""
    }
    
}
