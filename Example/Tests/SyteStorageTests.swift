//
//  SyteStorageTests.swift
//  Syte_Tests
//
//  Created by Artur Tarasenko on 29.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import Syte

class SyteStorageTests: XCTestCase {
    
    private var storage: SyteStorage?
    
    override func setUp() {
        super.setUp()
        storage = SyteStorage()
    }

    func testSessionId() throws {
        storage?.clearSessionId()
        let sesionId = storage?.getSessionId()
        XCTAssertNotNil(sesionId)
        XCTAssertNotEqual(sesionId, -1)
    }
    
    func testClearSessionId() throws {
        let sesionId = storage?.getSessionId()
        XCTAssertNotEqual(sesionId, -1)
        storage?.clearSessionId()
        XCTAssertNotEqual(sesionId, storage?.getSessionId())
    }
    
    func testGetUserId() throws {
        let userId = storage?.getUserId()
        XCTAssertNotNil(userId)
        XCTAssertNotEqual(userId, "")
    }
    
    func testAddViewedProduct() throws {
        storage?.addViewedProduct(sessionSku: "test1")
        storage?.addViewedProduct(sessionSku: "test2")
        storage?.addViewedProduct(sessionSku: "test3")
        let testArray = ["test1", "test2", "test3"]
        let currentProducts = storage?.getViewedProducts().components(separatedBy: ",")
        XCTAssertEqual(testArray, currentProducts)
    }
    
    func testGetEmptyViewedProducts() throws {
        let products = storage?.getViewedProducts()
        XCTAssertEqual("", products)
    }
    
    func testAddPopularSearch() throws {
        let testArray = ["test1", "test2", "test3"]
        let testLang = "testLang"
        storage?.addPopularSearch(data: testArray, lang: testLang)
        let popularSearches = storage?.getPopularSearch(lang: testLang).components(separatedBy: ",")
        XCTAssertEqual(testArray, popularSearches)
    }
    
    func testAddEmptyPopularSearch() throws {
        let testArray: [String] = []
        let testLang = ""
        storage?.addPopularSearch(data: testArray, lang: testLang)
        let popularSearches = storage?.getPopularSearch(lang: testLang)
        XCTAssertEqual("", popularSearches)
    }
    
    func testAddPopularSearchMultipleLangs() throws {
        let testArray: [String] = ["test"]
        let testLang1 = "testLang1"
        let testLang2 = "testLang2"
        storage?.addPopularSearch(data: testArray, lang: testLang1)
        storage?.addPopularSearch(data: testArray, lang: testLang2)
        let popularSearches = storage?.getPopularSearch(lang: testLang1)
        let popularSearches2 = storage?.getPopularSearch(lang: testLang2)
        XCTAssertEqual("test", popularSearches)
        XCTAssertEqual("test", popularSearches2)
    }
    
    func testGetPopularSearchNotExistLang() throws {
        XCTAssertEqual(storage?.getPopularSearch(lang: "testLangNotExist"), "")
    }
    
    func testClearPopularSearch() throws {
        let testArray = ["test1", "test2", "test3"]
        let testLang = "testLang"
        storage?.addPopularSearch(data: testArray, lang: testLang)
        let popularSearches = storage?.getPopularSearch(lang: testLang).components(separatedBy: ",")
        XCTAssertEqual(testArray, popularSearches)
        storage?.clearPopularSearch()
        let popularSearchesAfterClear = storage?.getPopularSearch(lang: testLang)
        XCTAssertEqual("", popularSearchesAfterClear)
    }
    
    func testAddTextSearchTerm() throws {
        let term = "testQuery"
        storage?.addTextSearchTerm(term: term)
        let storageTerms = storage?.getTextSearchTerms()
        XCTAssertNotNil(storageTerms)
        XCTAssertEqual(term, storageTerms)
        let term2 = "testQuery2"
        storage?.addTextSearchTerm(term: term2)
        let storageTerms2 = storage?.getTextSearchTerms()
        XCTAssertNotNil(storageTerms2)
        let compareData1 = ["testQuery2", "testQuery"]
        let storageTermsSeparated = storageTerms2?.components(separatedBy: ",")
        XCTAssertEqual(compareData1, storageTermsSeparated)
        let term3 = "testQuery3"
        let term4 = "testQuery4"
        storage?.addTextSearchTerm(term: term3)
        storage?.addTextSearchTerm(term: term4)
        let storageTerms3 = storage?.getTextSearchTerms()
        XCTAssertNotNil(storageTerms3)
        let compareData2 = ["testQuery4", "testQuery3", "testQuery2", "testQuery"]
        let storageTermsSeparated2 = storageTerms3?.components(separatedBy: ",")
        XCTAssertEqual(compareData2, storageTermsSeparated2)
    }
    
    func testRemoveLastTextSearchTermWhenGreatherThanMax() throws {
        for _ in 0..<50 {
            let term = UUID().uuidString
            storage?.addTextSearchTerm(term: term)
        }
        
        let storageTerms = storage?.getTextSearchTerms()
        XCTAssertNotNil(storageTerms)
        
        let storageTermsSeparated = storageTerms?.components(separatedBy: ",")
        XCTAssertEqual(50, storageTermsSeparated?.count)
        
        let term2 = "testQuery2"
        storage?.addTextSearchTerm(term: term2)
        
        let storageTerms2 = storage?.getTextSearchTerms()
        XCTAssertNotNil(storageTerms2)
        
        let storageTermsSeparated2 = storageTerms2?.components(separatedBy: ",")
        XCTAssertEqual(50, storageTermsSeparated2?.count)
    }
    
    func testGetEmptySearchTerms() throws {
        let terms = storage?.getTextSearchTerms()
        XCTAssertEqual("", terms)
    }
    
}
