//
//  ProvidersTests.swift
//  Syte_Tests
//
//  Created by Artur Tarasenko on 06.10.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import Syte

fileprivate class TestableBaseProvider: BaseProvider {}

class ProvidersTests: XCTestCase {

    func testBaseProvider() throws {
        let baseProvider = TestableBaseProvider()
        XCTAssertEqual(baseProvider.baseURL, URL(string: "https://cdn.syteapi.com")!)
        XCTAssertEqual(baseProvider.path, "")
        XCTAssertEqual(baseProvider.method, .get)
        switch baseProvider.task {
        case .requestPlain:
            break
        default:
            XCTFail("Wrong base provider task.")
        }
        XCTAssertEqual(baseProvider.sampleData, Data())
        XCTAssertEqual(baseProvider.headers, ["Content-type": "application/json"])
        switch baseProvider.authorizationType {
        case .basic:
            break
        default:
            XCTFail("Wrong base provider authorizationType.")
        }
    }

}
