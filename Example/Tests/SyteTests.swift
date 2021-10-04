//
//  SyteTests.swift
//  Syte_Tests
//
//  Created by Artur Tarasenko on 04.10.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import Syte

class SyteTests: BaseTests {
    
    let urlRequestData: UrlImageSearch = {
        let data = UrlImageSearch(imageUrl: "https://cdn-images.farfetch-contents.com/13/70/55/96/13705596_18130188_1000.jpg",
                                  productType: .discoveryButton)
        data.sku = "13705596"
        return data
    }()
    
    func testStartSessionWrongConfiguration() throws {
        let syteVar = Syte(configuration: SyteConfiguration(accountId: "", signature: ""))
        XCTAssertNil(syteVar)
    }
    
    func testStartSessionEmptyAccountId() throws {
        let syteVar = Syte(configuration: SyteConfiguration(accountId: "", signature: "test"))
        XCTAssertNil(syteVar)
    }
    
    func testStartSessionEmptySignature() throws {
        let syteVar = Syte(configuration: SyteConfiguration(accountId: "test", signature: ""))
        XCTAssertNil(syteVar)
    }
    
    func testGetConfiguration() throws {
        let configuration = syte.getConfiguration()
        XCTAssertEqual(configuration.accountId, "9165")
        XCTAssertEqual(configuration.signature, "601c206d0a7f780efb9360f3")
        XCTAssertNotEqual(configuration.sessionId, -1)
        XCTAssertNotNil(configuration.userId)
    }
    
    func testSetConfiguration() throws {
        let configuration = syte.getConfiguration()
        XCTAssertEqual(configuration.accountId, "9165")
        XCTAssertEqual(configuration.signature, "601c206d0a7f780efb9360f3")
        XCTAssertNotEqual(configuration.sessionId, -1)
        XCTAssertNotNil(configuration.userId)
        let currentLocale = configuration.locale
        XCTAssertNotNil(currentLocale)
        let testLocale = "testLocale"
        configuration.locale = testLocale
        XCTAssertNotNil(configuration)
        syte.setConfiguration(configuration: configuration)
        XCTAssertEqual(syte.getConfiguration().locale, testLocale)
    }
    
    func testGetSetLogLevel() throws {
        XCTAssertEqual(syte.logLevel, .verbose)
        syte.logLevel = .debug
        XCTAssertEqual(syte.logLevel, .debug)
    }
    
    func testGetSytePlatofrmSettings() throws {
        syte.getSytePlatformSettings { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.data)
            XCTAssertTrue(result.isSuccessful)
            XCTAssertEqual(result.resultCode, 200)
        }
    }
    
    func testFireEvents() throws {
        let eventInitialization = EventInitialization()
        syte.fire(event: eventInitialization)
        let items = syte.getViewedProducts()
        XCTAssertEqual(items, [])
        let pageEvent = EventPageView(sku: "test", pageName: "testPage")
        syte.fire(event: pageEvent)
        let itemsAfter = syte.getViewedProducts()
        XCTAssertEqual(itemsAfter, ["test"])
    }
    
    func testGetRecentTextSearches() throws {
        XCTAssertEqual(syte.getRecentTextSearches(), [""])
    }
    
    func testGetBoundsByUrl() throws {
        syte.getBounds(imageSearch: urlRequestData, completion: { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.data)
            XCTAssertTrue(result.isSuccessful)
            XCTAssertEqual(result.resultCode, 200)
        })
    }
    
}
