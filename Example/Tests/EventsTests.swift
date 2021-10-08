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
        let event = EventCheckoutStart(price: 2,
                                                    currency: "UAH",
                                                    productList: [Product(sku: "test", quantity: 2, price: 2)],
                                                    pageName: "sdk-test")
        
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventCheckoutStart.self, from: data)
        let testBody = """
        {"value":2,"currency":"UAH","eventsTags":["ecommerce"],"syteUrlReferer":"sdk-test","name":"checkout_start","products":[{"sku":"test","quantity":2,"price":2}]}
        """
        let body = event.getRequestBodyString()
        XCTAssertEqual(testBody, body)
        XCTAssertEqual(event, decodedEvent)
    }
    
    func testEventBBClick() throws {
        let event = EventBBClick(imageUrl: "url",
                                        category: "category",
                                        gender: "gender",
                                        catalog: Catalog.general.getName(),
                                        pageName: "sdk-test")
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventBBClick.self, from: data)
        let testBody = """
        {"gender":"gender","eventsTags":["camera"],"category":"category","image_url":"url","syteUrlReferer":"sdk-test","name":"fe_bb_bb_click","catalog":"general"}
        """
        let body = event.getRequestBodyString()
        XCTAssertEqual(testBody, body)
        XCTAssertEqual(event, decodedEvent)
    }
    
    func testEventBBShowLayout() throws {
        let event = EventBBShowLayout(imageUrl: "url", numOfBBs: 2, pageName: "sdk-test")
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventBBShowLayout.self, from: data)
        let testBody = """
        {"eventsTags":["camera"],"image_url":"url","syteUrlReferer":"sdk-test","num_of_bbs":2,"name":"fe_bb_show_layout"}
        """
        let body = event.getRequestBodyString()
        XCTAssertEqual(testBody, body)
        XCTAssertEqual(event, decodedEvent)
    }
    
    func testEventBBShowResults() throws {
        let event = EventBBShowResults(imageUrl: "url", category: "category", resultsCount: 2, pageName: "sdk-test")
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventBBShowResults.self, from: data)
        let testBody = """
        {"name":"fe_bb_show_results","eventsTags":["camera"],"image_url":"url","syteUrlReferer":"sdk-test","results_count":2,"category":"category"}
        """
        let body = event.getRequestBodyString()
        XCTAssertEqual(testBody, body)
        XCTAssertEqual(event, decodedEvent)
    }
    
    func testEventCameraButtonClick() throws {
        let event = EventCameraButtonClick(placement: Placement.default.getName(), pageName: "sdk-test")
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventCameraButtonClick.self, from: data)
        let testBody = """
        {\"placement\":\"default\",\"eventsTags\":[\"camera\"],\"syteUrlReferer\":\"sdk-test\",\"name\":\"fe_camera_button_click\"}
        """
        let body = event.getRequestBodyString()
        XCTAssertEqual(event, decodedEvent)
        XCTAssertEqual(testBody, body)
    }
    
    func testEventCameraButtonImpression() throws {
        let event = EventCameraButtonImpression(pageName: "sdk-test")
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventCameraButtonImpression.self, from: data)
        XCTAssertEqual(event, decodedEvent)
    }
    
    func testEventCheckoutComplete() throws {
        let event = EventCheckoutComplete(id: "1",
                                                          value: 2,
                                                          currency: "USD",
                                                          productList: [Product(sku: "test", quantity: 2, price: 2)],
                                                          pageName: "sdk-test")
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventCheckoutComplete.self, from: data)
        let testBody = """
        {"eventsTags":["ecommerce"],"products":[{"sku":"test","quantity":2,"price":2}],"id":"1","value":2,"currency":"USD","syteUrlReferer":"sdk-test","name":"checkout_complete"}
        """
        let body = event.getRequestBodyString()
        XCTAssertEqual(testBody, body)
        XCTAssertEqual(event, decodedEvent)
    }
    
    func testEventDiscoveryButtonClick() throws {
        let event = EventDiscoveryButtonClick(imageSrc: "src", placement: Placement.default.getName(), pageName: "sdk-test")
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventDiscoveryButtonClick.self, from: data)
        let testBody = """
        {"imageSrc":"src","placement":"default","syteUrlReferer":"sdk-test","name":"fe_discovery_button_click","eventsTags":["discovery_button"]}
        """
        let body = event.getRequestBodyString()
        XCTAssertEqual(testBody, body)
        XCTAssertEqual(event, decodedEvent)
    }
    
    func testEventDiscoveryButtonImpression() throws {
        let event = EventDiscoveryButtonImpression(pageName: "sdk-test")
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventDiscoveryButtonImpression.self, from: data)
        XCTAssertEqual(event, decodedEvent)
    }
    
    func testEventOfferClick() throws {
        let event = EventOfferClick(sku: "sku", position: 123, pageName: "sdk-test")
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventOfferClick.self, from: data)
        let testBody = """
        {"name":"fe_offer_click","eventsTags":["discovery_button","camera"],"syteUrlReferer":"sdk-test","position":123,"sku":"sku"}
        """
        let body = event.getRequestBodyString()
        XCTAssertEqual(testBody, body)
        XCTAssertEqual(event, decodedEvent)
    }
    
    func testEventPageView() throws {
        let event = EventPageView(sku: "TEST-SKU-PAGE-View", pageName: "sdk-test")
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventPageView.self, from: data)
        XCTAssertEqual(event, decodedEvent)
        syte.fire(event: event)
        XCTAssertTrue(syte.getViewedProducts().contains(where: { $0 == "TEST-SKU-PAGE-View" }))
        let testBody = """
        {"eventsTags":["ecommerce"],"syteUrlReferer":"sdk-test","name":"fe_page_view","sku":"TEST-SKU-PAGE-View"}
        """
        let body = event.getRequestBodyString()
        XCTAssertEqual(testBody, body)
    }
    
    func testEventProductsAddedToCart() throws {
        let event = EventProductsAddedToCart(productList: [Product(sku: "test", quantity: 2, price: 2)], pageName: "sdk-test")
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventProductsAddedToCart.self, from: data)
        let testBody = """
        {"eventsTags":["ecommerce"],"syteUrlReferer":"sdk-test","name":"products_added_to_cart","products":[{"sku":"test","quantity":2,"price":2}]}
        """
        let body = event.getRequestBodyString()
        XCTAssertEqual(testBody, body)
        XCTAssertEqual(event, decodedEvent)
    }
    
    func testEventShopTheLookOfferClick() throws {
        let event = EventShopTheLookOfferClick(sku: "sku", position: 123, pageName: "sdk-test")
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventShopTheLookOfferClick.self, from: data)
        let testBody = """
        {"name":"fe_offer_click","eventsTags":["shop_the_look"],"syteUrlReferer":"sdk-test","position":123,"sku":"sku"}
        """
        let body = event.getRequestBodyString()
        XCTAssertEqual(testBody, body)
        XCTAssertEqual(event, decodedEvent)
    }
    
    func testEventShopTheLookShowLayout() throws {
        let event = EventShopTheLookShowLayout(resultsCount: 3, pageName: "sdk-test")
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventShopTheLookShowLayout.self, from: data)
        let testBody = """
        {"eventsTags":["shop_the_look"],"syteUrlReferer":"sdk-test","results_count":3,"name":"fe_stl_show_layout"}
        """
        let body = event.getRequestBodyString()
        XCTAssertEqual(testBody, body)
        XCTAssertEqual(event, decodedEvent)
    }
    
    func testEventSimilarItemsOfferClick() throws {
        let event = EventSimilarItemsOfferClick(sku: "sku", position: 1, pageName: "sdk-test")
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventSimilarItemsOfferClick.self, from: data)
        let testBody = """
        {"name":"fe_offer_click","eventsTags":["similar_items"],"syteUrlReferer":"sdk-test","position":1,"sku":"sku"}
        """
        let body = event.getRequestBodyString()
        XCTAssertEqual(testBody, body)
        XCTAssertEqual(event, decodedEvent)
    }
    
    func testEventSimilarItemsShowLayout() throws {
        let event = EventSimilarItemsShowLayout(resultsCount: 2, pageName: "sdk-test")
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventSimilarItemsShowLayout.self, from: data)
        let testBody = """
        {"eventsTags":["similar_items"],"syteUrlReferer":"sdk-test","results_count":2,"name":"fe_si_show_layout"}
        """
        let body = event.getRequestBodyString()
        XCTAssertEqual(testBody, body)
        XCTAssertEqual(event, decodedEvent)
    }
    
    func testEventTextShowResults() throws {
        let event = EventTextShowResults(query: "text",
                                                        type: TextSearchEventType.popularSearch.getName(),
                                                        exactCount: 10,
                                                        pageName: "sdk-test")
        let data = try encoder.encode(event)
        let decodedEvent = try decoder.decode(EventTextShowResults.self, from: data)
        let testBody = """
        {"eventsTags":["text_search"],"query":"text","exact_count":10,"type":"popular_search","syteUrlReferer":"sdk-test","name":"fe_text_show_results"}
        """
        let body = event.getRequestBodyString()
        XCTAssertEqual(testBody, body)
        XCTAssertEqual(event, decodedEvent)
    }
    
    func testBaseSyteEvent() throws {
        let baseEvent = BaseSyteEvent(name: "custom_event", syteUrlReferer: "sdk-test", tag: EventsTag.syte_ios_sdk)
        let data = try encoder.encode(baseEvent)
        let decodedEvent = try decoder.decode(BaseSyteEvent.self, from: data)
        XCTAssertEqual(baseEvent, decodedEvent)
    }

}
