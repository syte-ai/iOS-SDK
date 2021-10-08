//
//  EventsTests.swift
//  Syte_Tests
//
//  Created by Artur Tarasenko on 05.10.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import Syte

class EventsTests: BaseTests {
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func testEventInitialization() throws {
        let eventInitialization = EventInitialization()
        let data = try encoder.encode(eventInitialization)
        let decodedEvent = try decoder.decode(EventInitialization.self, from: data)
        XCTAssertEqual(eventInitialization, decodedEvent)
    }

    func testEventCheckoutStart() throws {
        let eventCheckoutStart = EventCheckoutStart(price: 2,
                                                    currency: "UAH",
                                                    productList: [Product(sku: "test", quantity: 2, price: 2)],
                                                    pageName: "sdk-test")
        
        let data = try encoder.encode(eventCheckoutStart)
        let decodedEvent = try decoder.decode(EventCheckoutStart.self, from: data)
        XCTAssertEqual(eventCheckoutStart, decodedEvent)
    }
    
    func testEventBBClick() throws {
        let eventBBClick = EventBBClick(imageUrl: "url",
                                        category: "category",
                                        gender: "gender",
                                        catalog: Catalog.general.getName(),
                                        pageName: "sdk-test")
        let data = try encoder.encode(eventBBClick)
        let decodedEvent = try decoder.decode(EventBBClick.self, from: data)
        XCTAssertEqual(eventBBClick, decodedEvent)
    }
    
    func testEventBBShowLayout() throws {
        let eventBBShowLayout = EventBBShowLayout(imageUrl: "url", numOfBBs: 2, pageName: "sdk-test")
        let data = try encoder.encode(eventBBShowLayout)
        let decodedEvent = try decoder.decode(EventBBShowLayout.self, from: data)
        XCTAssertEqual(eventBBShowLayout, decodedEvent)
    }
    
    func testEventBBShowResults() throws {
        let eventBBShowResults = EventBBShowResults(imageUrl: "url", category: "category", resultsCount: 2, pageName: "sdk-test")
        let data = try encoder.encode(eventBBShowResults)
        let decodedEvent = try decoder.decode(EventBBShowResults.self, from: data)
        XCTAssertEqual(eventBBShowResults, decodedEvent)
    }
    
    func testEventCameraButtonClick() throws {
        let eventCameraButtonClick = EventCameraButtonClick(placement: Placement.default.getName(), pageName: "sdk-test")
        let data = try encoder.encode(eventCameraButtonClick)
        let decodedEvent = try decoder.decode(EventCameraButtonClick.self, from: data)
        let testBody = """
        {\"placement\":\"default\",\"eventsTags\":[\"camera\"],\"syteUrlReferer\":\"sdk-test\",\"name\":\"fe_camera_button_click\"}
        """
        let body = eventCameraButtonClick.getRequestBodyString()
        XCTAssertEqual(eventCameraButtonClick, decodedEvent)
        XCTAssertEqual(testBody, body)
    }
    
    func testEventCameraButtonImpression() throws {
        let eventCameraButtonImpression = EventCameraButtonImpression(pageName: "sdk-test")
        let data = try encoder.encode(eventCameraButtonImpression)
        let decodedEvent = try decoder.decode(EventCameraButtonImpression.self, from: data)
        XCTAssertEqual(eventCameraButtonImpression, decodedEvent)
    }
    
    func testEventCheckoutComplete() throws {
        let eventCheckoutComplete = EventCheckoutComplete(id: "1",
                                                          value: 2,
                                                          currency: "USD",
                                                          productList: [Product(sku: "test", quantity: 2, price: 2)],
                                                          pageName: "sdk-test")
        let data = try encoder.encode(eventCheckoutComplete)
        let decodedEvent = try decoder.decode(EventCheckoutComplete.self, from: data)
        XCTAssertEqual(eventCheckoutComplete, decodedEvent)
    }
    
    func testEventDiscoveryButtonClick() throws {
        let eventDiscoveryButtonClick = EventDiscoveryButtonClick(imageSrc: "src", placement: Placement.default.getName(), pageName: "sdk-test")
        let data = try encoder.encode(eventDiscoveryButtonClick)
        let decodedEvent = try decoder.decode(EventDiscoveryButtonClick.self, from: data)
        XCTAssertEqual(eventDiscoveryButtonClick, decodedEvent)
    }
    
    func testEventDiscoveryButtonImpression() throws {
        let eventDiscoveryButtonImpression = EventDiscoveryButtonImpression(pageName: "sdk-test")
        let data = try encoder.encode(eventDiscoveryButtonImpression)
        let decodedEvent = try decoder.decode(EventDiscoveryButtonImpression.self, from: data)
        XCTAssertEqual(eventDiscoveryButtonImpression, decodedEvent)
    }
    
    func testEventOfferClick() throws {
        let eventOfferClick = EventOfferClick(sku: "sku", position: 123, pageName: "sdk-test")
        let data = try encoder.encode(eventOfferClick)
        let decodedEvent = try decoder.decode(EventOfferClick.self, from: data)
        XCTAssertEqual(eventOfferClick, decodedEvent)
    }
    
    func testEventPageView() throws {
        let eventPageView = EventPageView(sku: "TEST-SKU-PAGE-View", pageName: "sdk-test")
        let data = try encoder.encode(eventPageView)
        let decodedEvent = try decoder.decode(EventPageView.self, from: data)
        XCTAssertEqual(eventPageView, decodedEvent)
        syte.fire(event: eventPageView)
        XCTAssertTrue(syte.getViewedProducts().contains(where: { $0 == "TEST-SKU-PAGE-View" }))
    }
    
    func testEventProductsAddedToCart() throws {
        let eventProductsAddedToCart = EventProductsAddedToCart(productList: [Product(sku: "test", quantity: 2, price: 2)], pageName: "sdk-test")
        let data = try encoder.encode(eventProductsAddedToCart)
        let decodedEvent = try decoder.decode(EventProductsAddedToCart.self, from: data)
        XCTAssertEqual(eventProductsAddedToCart, decodedEvent)
    }
    
    func testEventShopTheLookOfferClick() throws {
        let eventShopTheLookOfferClick = EventShopTheLookOfferClick(sku: "sku", position: 123, pageName: "sdk-test")
        let data = try encoder.encode(eventShopTheLookOfferClick)
        let decodedEvent = try decoder.decode(EventShopTheLookOfferClick.self, from: data)
        XCTAssertEqual(eventShopTheLookOfferClick, decodedEvent)
    }
    
    func testEventShopTheLookShowLayout() throws {
        let eventShopTheLookShowLayout = EventShopTheLookShowLayout(resultsCount: 3, pageName: "sdk-test")
        let data = try encoder.encode(eventShopTheLookShowLayout)
        let decodedEvent = try decoder.decode(EventShopTheLookShowLayout.self, from: data)
        XCTAssertEqual(eventShopTheLookShowLayout, decodedEvent)
    }
    
    func testEventSimilarItemsOfferClick() throws {
        let eventSimilarItemsOfferClick = EventSimilarItemsOfferClick(sku: "sku", position: 1, pageName: "sdk-test")
        let data = try encoder.encode(eventSimilarItemsOfferClick)
        let decodedEvent = try decoder.decode(EventSimilarItemsOfferClick.self, from: data)
        XCTAssertEqual(eventSimilarItemsOfferClick, decodedEvent)
    }
    
    func testEventSimilarItemsShowLayout() throws {
        let eventSimilarItemsShowLayout = EventSimilarItemsShowLayout(resultsCount: 2, pageName: "sdk-test")
        let data = try encoder.encode(eventSimilarItemsShowLayout)
        let decodedEvent = try decoder.decode(EventSimilarItemsShowLayout.self, from: data)
        XCTAssertEqual(eventSimilarItemsShowLayout, decodedEvent)
    }
    
    func testEventTextShowResults() throws {
        let eventTextShowResults = EventTextShowResults(query: "text",
                                                        type: TextSearchEventType.popularSearch.getName(),
                                                        exactCount: 10,
                                                        pageName: "sdk-test")
        let data = try encoder.encode(eventTextShowResults)
        let decodedEvent = try decoder.decode(EventTextShowResults.self, from: data)
        XCTAssertEqual(eventTextShowResults, decodedEvent)
    }
    
    func testBaseSyteEvent() throws {
        let baseEvent = BaseSyteEvent(name: "custom_event", syteUrlReferer: "sdk-test", tag: EventsTag.syte_ios_sdk)
        let data = try encoder.encode(baseEvent)
        let decodedEvent = try decoder.decode(BaseSyteEvent.self, from: data)
        XCTAssertEqual(baseEvent, decodedEvent)
    }

}
