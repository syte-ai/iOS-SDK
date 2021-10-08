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
        XCTAssertEqual(Utils.viewedProductsString(viewedProducts: viewedProductsSet), "test1,test2")
        XCTAssertEqual(Utils.viewedProductsString(viewedProducts: []), nil)
        XCTAssertEqual(Utils.viewedProductsJSONArray(viewedProducts: viewedProductsSet), "[\"test1\",\"test2\"]")
        XCTAssertEqual(Utils.viewedProductsJSONArray(viewedProducts: []), nil)
        XCTAssertEqual(Utils.viewedProductsJSONArray(sku: "testSKU"), "[testSKU]")
        XCTAssertEqual(Utils.viewedProductsJSONArray(sku: nil), nil)
        XCTAssertEqual(Utils.textSearchTermsString(terms: ["test1", "test2"]), "test1,test2")
        XCTAssertEqual(Utils.generateFiltersString(filters: [:]), nil)
        XCTAssertEqual(Utils.generateFiltersString(filters: ["test": ["1", "2"]]), "{\"test\":[\"1\",\"2\"}")
        
    }
    
}
