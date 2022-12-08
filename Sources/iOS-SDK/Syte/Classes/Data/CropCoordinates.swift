//
//  CropCoordinates.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

/**
 It is used to define a specific image bounds to retrieve the data for.
 The coordinates must be relative in range from 0 to 1.
 */
public class CropCoordinates {
    
    private var x1: Double = 0
    private var y1: Double = 0
    private var x2: Double = 0
    private var y2: Double = 0
    
    public init(x1: Double, y1: Double, x2: Double, y2: Double) {
        self.x1 = x1
        self.y1 = y1
        self.x2 = x2
        self.y2 = y2
    }
    
    public func toString() -> String {
        "{\"x\":\(x1)" + ",\"y\":\(y1)" + ",\"x2\":\(x2)" + ",\"y2\":\(y2)}"
    }
    
}
