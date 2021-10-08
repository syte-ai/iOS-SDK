//
//  JsonValueTests.swift
//  Syte_Tests
//
//  Created by Artur Tarasenko on 08.10.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import Syte

class JsonValueTests: XCTestCase {

    // swiftlint:disable function_body_length
    func testJsonValues() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let stringValue: String = "testString"
        let intValue: Int = 1
        let doubleValue: Double = 1.5
        let boolValue: Bool = false
        let dictValue: [String: String] = ["testKey": "TestValue"]
        let arrayValue: [Int] = [1, 2, 3, 4, 5]
        
        let dataString = try encoder.encode(stringValue)
        let dataInt = try encoder.encode(intValue)
        let dataDouble = try encoder.encode(doubleValue)
        let dataBool = try encoder.encode(boolValue)
        let dataDict = try encoder.encode(dictValue)
        let dataArray = try encoder.encode(arrayValue)
        
        let decodedString = try decoder.decode(JSONValue.self, from: dataString)
        let decodedInt = try decoder.decode(JSONValue.self, from: dataInt)
        let decodedDouble = try decoder.decode(JSONValue.self, from: dataDouble)
        let decodedBool = try decoder.decode(JSONValue.self, from: dataBool)
        let decodedDict = try decoder.decode(JSONValue.self, from: dataDict)
        let decodedArray = try decoder.decode(JSONValue.self, from: dataArray)
        
        let jsonString = decodedString.values() as? String
        let jsonInt = decodedInt.values() as? Int
        let jsonDouble = decodedDouble.values() as? Double
        let jsonBool = decodedBool.values() as? Bool
        let jsonDict = decodedDict.values() as? [String: String]
        let jsonArray = decodedArray.values() as? [Int]
        
        XCTAssertEqual(jsonString, stringValue)
        XCTAssertEqual(jsonInt, intValue)
        XCTAssertEqual(jsonDouble, doubleValue)
        XCTAssertEqual(jsonBool, boolValue)
        XCTAssertEqual(jsonDict, dictValue)
        XCTAssertEqual(jsonArray, arrayValue)
        
        let jsonValueStringEncoded = try encoder.encode(decodedString)
        let jsonValueIntEncoded = try encoder.encode(decodedInt)
        let jsonValueDoubleEncoded = try encoder.encode(decodedDouble)
        let jsonValueBoolEncoded = try encoder.encode(decodedBool)
        let jsonValueDictEncoded = try encoder.encode(decodedDict)
        let jsonValueArrayEncoded = try encoder.encode(decodedArray)
        
        XCTAssertNotNil(jsonValueStringEncoded)
        XCTAssertNotNil(jsonValueIntEncoded)
        XCTAssertNotNil(jsonValueDoubleEncoded)
        XCTAssertNotNil(jsonValueBoolEncoded)
        XCTAssertNotNil(jsonValueDictEncoded)
        XCTAssertNotNil(jsonValueArrayEncoded)
        
    }
    // swiftlint:enable function_body_length

}
