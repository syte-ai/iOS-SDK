//
//  EventShopTheLookShowLayout.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation

/**
 This event should be sent to Syte every time a shop the look carousel is visible
 */
public class EventShopTheLookShowLayout: BaseSyteEvent {
    
    // The number of displayed results
    private let resultsCount: Int
    
    enum CodingKeys: String, CodingKey {
        case resultsCount = "results_count"
    }
    
    public init(resultsCount: Int, pageName: String) {
        self.resultsCount = resultsCount
        super.init(name: "fe_stl_show_layout", syteUrlReferer: pageName, tag: .shopTheLook)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        resultsCount = try container.decode(Int.self, forKey: .resultsCount)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(resultsCount, forKey: .resultsCount)
        try super.encode(to: encoder)
    }
    
    override public func getRequestBodyString() -> String {
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(self)
        let json = String(data: jsonData ?? Data(), encoding: String.Encoding.utf8)
        
        return json ?? ""
    }
    
}
