//
//  Bounds.swift
//  Syte
//
//  Created by David Jinely on 6/4/19.
//  Copyright © 2019 David Jinely. All rights reserved.
//

import Foundation

open class ImageBounds {
    public var offers: String?
    public var label: String?
    public var gender: String?
    public var center: CGPoint?
    public var b1: CGPoint?
    public var b2: CGPoint?
    public var catalog: String?
    init(rawData: AnyObject) {
        offers = rawData["offers"] as? String
        label = rawData["label"] as? String
        gender = rawData["gender"] as? String
        catalog = rawData["catalog"] as? String
        center = getPoint(key: "center", in: rawData)
        b1 = getPoint(key: "b1", in: rawData)
        b2 = getPoint(key: "b2", in: rawData)
    }
    
    private func getPoint(key: String, in rawData: AnyObject) -> CGPoint? {
        guard let data = rawData[key] as? [CGFloat] else { return nil }
        return CGPoint.createFrom(values: data)
    }
}

extension CGPoint {
    static func createFrom(values: [CGFloat]) -> CGPoint? {
        guard values.count == 2 else { return nil }
        return CGPoint(x: values[0], y: values[1])
    }
}
