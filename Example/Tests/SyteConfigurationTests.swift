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
        let configuration = SyteConfiguration(accountId: "", signature: "")
        configuration.addViewedProduct(sessionSku: "")
        configuration.addViewedProduct(sessionSku: "test1")
        configuration.addViewedProduct(sessionSku: "test2")
        configuration.addViewedProduct(sessionSku: "test3")
        let testArray: Set<String> = ["test1", "test2", "test3"]
        XCTAssertEqual(testArray, configuration.getViewedProducts())
    }
    
    func testSessionSkusStringSimilarInput() throws {   
        let configuration = SyteConfiguration(accountId: "", signature: "")
        configuration.addViewedProduct(sessionSku: "")
        configuration.addViewedProduct(sessionSku: "test1")
        configuration.addViewedProduct(sessionSku: "test2")
        configuration.addViewedProduct(sessionSku: "test1")
        let testArray: Set<String> = ["test1", "test2"]
        XCTAssertEqual(testArray, configuration.getViewedProducts())
    }
    
}
