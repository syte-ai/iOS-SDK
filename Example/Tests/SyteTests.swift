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
        syte.logLevel = .debug
        XCTAssertEqual(syte.logLevel, .debug)
    }
    
    func testGetSytePlatofrmSettings() throws {
        let expectation = XCTestExpectation()
        syte.getPlatformSettings { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.data)
            XCTAssertTrue(result.isSuccessful)
            XCTAssertEqual(result.resultCode, 200)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 60)
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
        let expectation = XCTestExpectation()
        syte.getBoundsForImageUrl(imageSearch: urlRequestData) { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.data)
            XCTAssertTrue(result.isSuccessful)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 60)
    }
    
    func testGetBoundsByUrlEmptyUrl() throws {
        let expectation = XCTestExpectation()
        syte.getBoundsForImageUrl(imageSearch: UrlImageSearch(imageUrl: "", productType: .discoveryButton)) { result in
            XCTAssertNotNil(result)
            XCTAssertNil(result.data)
            XCTAssertFalse(result.isSuccessful)
            XCTAssertEqual(result.resultCode, -1)
            XCTAssertEqual(result.errorMessage, "Image URI can not be empty.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 60)
    }
    
    func testGetItemsForBoundWithCrop() throws {
        let expectation = XCTestExpectation()
        let requestData = urlRequestData
        let coordinates = CropCoordinates(x1: 0.35371503233909607,
                                          y1: 0.32111090421676636,
                                          x2: 0.6617449522018433,
                                          y2: 0.6626847386360168)
        requestData.coordinates = coordinates
        syte.getBoundsForImageUrl(imageSearch: requestData) { [weak self] result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.data)
            XCTAssertTrue(result.isSuccessful)
            XCTAssertEqual(result.resultCode, 200)
            let bound = result.data?.bounds?.first
            XCTAssertNotNil(bound)
            
            self?.syte.getItemsForBound(bound: bound!, cropCoordinates: nil) { itemsResult in
                XCTAssertNotNil(itemsResult)
                XCTAssertNotNil(itemsResult.data)
                XCTAssertTrue(itemsResult.isSuccessful)
                XCTAssertEqual(itemsResult.resultCode, 200)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 60)
    }
    
    func testGetItemsForBoundWithoutCrop() throws {
        let expectation = XCTestExpectation()
        syte.getBoundsForImageUrl(imageSearch: urlRequestData) { [weak self] result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.data)
            XCTAssertTrue(result.isSuccessful)
            XCTAssertEqual(result.resultCode, 200)
            let bound = result.data?.bounds?.first
            XCTAssertNotNil(bound)
            
            self?.syte.getItemsForBound(bound: bound!, cropCoordinates: nil) { itemsResult in
                XCTAssertNotNil(itemsResult)
                XCTAssertNotNil(itemsResult.data)
                XCTAssertTrue(itemsResult.isSuccessful)
                XCTAssertEqual(itemsResult.resultCode, 200)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 60)
    }
    
    func testGetItemsForBoundWithCustopOptions() throws {
        let expectation = XCTestExpectation()
        let requestData = urlRequestData
        requestData.options = ["test": "test"]
        syte.getBoundsForImageUrl(imageSearch: requestData) { [weak self] result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.data)
            XCTAssertTrue(result.isSuccessful)
            XCTAssertEqual(result.resultCode, 200)
            let bound = result.data?.bounds?.first
            XCTAssertNotNil(bound)
            
            self?.syte.getItemsForBound(bound: bound!, cropCoordinates: nil) { itemsResult in
                XCTAssertNotNil(itemsResult)
                XCTAssertNotNil(itemsResult.data)
                XCTAssertTrue(itemsResult.isSuccessful)
                XCTAssertEqual(itemsResult.resultCode, 200)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 60)
    }
    
    func testGetBoundsByImage() throws {
        let expectation = XCTestExpectation()
        syte.getBoundsForImage(imageSearch: ImageSearch(image: UIImage())) { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.data)
            XCTAssertTrue(result.isSuccessful)
            XCTAssertEqual(result.resultCode, 200)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 60)
    }
    
    func testGetSimilars() throws {
        let expectation = XCTestExpectation()
        let similarProducts = SimilarProducts(sku: "PZZ70556-105",
                                              imageUrl: "https://sytestorageeu.blob.core.windows.net/text-static-feeds/boohoo_direct/PZZ70556-105.jpg?se=2023-10-31T19%3A05%3A46Z&sp=r&sv=2018-03-28&sr=b&sig=DQe1/iuTzLpl/hZhMzmb5jJF8qw41GdNlREzZvunw4k%3D")
        similarProducts.personalizedRanking = !syte.getViewedProducts().isEmpty
        syte.getSimilarProducts(similarProducts: similarProducts) { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.data)
            XCTAssertTrue(result.isSuccessful)
            XCTAssertEqual(result.resultCode, 200)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 60)
    }
    
    func testShopTheLook() throws {
        let expectation = XCTestExpectation()
        let shopTheLook = ShopTheLook(sku: "PZZ70556-105",
                                      imageUrl: "https://sytestorageeu.blob.core.windows.net/text-static-feeds/boohoo_direct/PZZ70556-105.jpg?se=2023-10-31T19%3A05%3A46Z&sp=r&sv=2018-03-28&sr=b&sig=DQe1/iuTzLpl/hZhMzmb5jJF8qw41GdNlREzZvunw4k%3D")
        shopTheLook.personalizedRanking = !syte.getViewedProducts().isEmpty
        shopTheLook.limitPerBound = 4
        syte.getShopTheLook(shopTheLook: shopTheLook) { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.data)
            XCTAssertTrue(result.isSuccessful)
            XCTAssertEqual(result.resultCode, 200)
            let shopTheLookData = result.data!
            XCTAssertEqual(shopTheLookData.items?.first?.items?.count, 4)
            let allItems = shopTheLookData.getItemsForAllLabels()
            let allItemsForceZipFalse = shopTheLookData.getItemsForAllLabels(forceZip: false)
            let allItemsForceZipTrue = shopTheLookData.getItemsForAllLabels(forceZip: true)
            XCTAssertEqual(allItems.count, allItemsForceZipFalse.count)
            XCTAssertEqual(allItems.count, allItemsForceZipTrue.count)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 60)
    }
        
    func testGetPersonalization() throws {
        let expectation = XCTestExpectation()
        syte.getConfiguration().addViewedProduct(sessionSku: "PZZ70556-105")
        let personalization = Personalization()
        syte.getPersonalization(personalization: personalization) { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.data)
            XCTAssertTrue(result.isSuccessful)
            XCTAssertEqual(result.resultCode, 200)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 60)
    }
    
    func testGetPopularSearches() throws {
        let expectation = XCTestExpectation()
        let lang = "en_US"
        syte.getPopularSearches(lang: lang) { [weak self] result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.data)
            XCTAssertTrue(result.isSuccessful)
            XCTAssertEqual(result.resultCode, 200)
            self?.syte.getPopularSearches(lang: lang, completion: { result in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.data)
                XCTAssertTrue(result.isSuccessful)
                XCTAssertEqual(result.resultCode, 200)
                expectation.fulfill()
            })
        }
        wait(for: [expectation], timeout: 60)
    }
    
    func testGetTextSearch() throws {
        let expectation = XCTestExpectation()
        syte.getTextSearch(textSearch: TextSearch(query: "dress", lang: "en_US")) { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.data)
            XCTAssertTrue(result.isSuccessful)
            XCTAssertEqual(result.resultCode, 200)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 60)
    }
    
    func testGetTextSearchWithFilter() throws {
        let expectation = XCTestExpectation()
        let textSearch = TextSearch(query: "dress", lang: "en_US")
        textSearch.textSearchSorting = .priceAsc
        syte.getTextSearch(textSearch: textSearch) { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.data)
            XCTAssertTrue(result.isSuccessful)
            XCTAssertEqual(result.resultCode, 200)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 60)
    }
    
    func testGetTextSearchWithWrongData() throws {
        let expectation = XCTestExpectation()
        let textSearch = TextSearch(query: "", lang: "")
        textSearch.textSearchSorting = .priceAsc
        textSearch.size = -1
        textSearch.from = -1
        syte.getTextSearch(textSearch: textSearch) { result in
            XCTAssertNotNil(result)
            XCTAssertNil(result.data)
            XCTAssertFalse(result.isSuccessful)
            XCTAssertEqual(result.resultCode, -1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 60)
    }
    
    func testGetAutocomplete() throws {
        let expectation = XCTestExpectation()
        syte.getAutoCompleteForTextSearch(query: "d", lang: "en_US") { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.data)
            XCTAssertTrue(result.isSuccessful)
            XCTAssertEqual(result.resultCode, 200)
            let error = result.data?.error?.values()
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 60)
    }
    
    func testGetAutocompleteEmptyLang() throws {
        let expectation = XCTestExpectation()
        syte.getAutoCompleteForTextSearch(query: "d", lang: nil) { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.data)
            XCTAssertTrue(result.isSuccessful)
            XCTAssertEqual(result.resultCode, 200)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 60)
    }
    
}
