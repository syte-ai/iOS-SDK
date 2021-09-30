//
//  SyteConfigurationTests.swift
//  Syte_Tests
//
//  Created by Artur Tarasenko on 28.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import Syte

class SyteConfigurationTests: BaseTests {

    func testSessionSkus() throws {
        try syte?.addViewedItem(sku: "test1")
        try syte?.addViewedItem(sku: "test2")
        try syte?.addViewedItem(sku: "test3")
        let testArray: Set<String> = ["test1", "test2", "test3"]
        XCTAssertEqual(testArray, configuration?.getViewedProducts())
    }
    
    func testSessionSkusStringSimilarInput() throws {
        try syte?.addViewedItem(sku: "test1")
        try syte?.addViewedItem(sku: "test2")
        try syte?.addViewedItem(sku: "test1")
        let testArray: Set<String> = ["test1", "test2"]
        XCTAssertEqual(testArray, configuration?.getViewedProducts())
    }
    
}
