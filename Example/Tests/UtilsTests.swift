//
//  UtilsTests.swift
//  Syte_Tests
//
//  Created by Artur Tarasenko on 07.10.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import Syte

class UtilsTests: XCTestCase {

    func testUtils() throws {
        let viewedProductsSet: Set<String> = ["test1", "test2"]
        let viewedProductsString = Utils.viewedProductsString(viewedProducts: viewedProductsSet)
        let viewedProductsStringCorrect = viewedProductsString == "test2,test1" || viewedProductsString == "test1,test2"
        let viewedProductsJson = Utils.viewedProductsJSONArray(viewedProducts: viewedProductsSet)
        let viewedProductsJsonCorrect = viewedProductsJson == "[\"test2\",\"test1\"]" || viewedProductsJson == "[\"test1\",\"test2\"]"
        XCTAssertTrue(viewedProductsStringCorrect)
        XCTAssertEqual(Utils.viewedProductsString(viewedProducts: []), nil)
        XCTAssertTrue(viewedProductsJsonCorrect)
        XCTAssertEqual(Utils.viewedProductsJSONArray(viewedProducts: []), nil)
        XCTAssertEqual(Utils.viewedProductsJSONArray(sku: "testSKU"), "[testSKU]")
        XCTAssertEqual(Utils.viewedProductsJSONArray(sku: nil), nil)
        XCTAssertEqual(Utils.textSearchTermsString(terms: ["test1", "test2"]), "test1,test2")
        XCTAssertEqual(Utils.generateFiltersString(filters: [:]), nil)
        XCTAssertEqual(Utils.generateFiltersString(filters: ["test": ["1", "2"]]), "{\"test\":[\"1\",\"2\"}")
        
    }
    
}
