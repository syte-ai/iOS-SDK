//
//  LoggerTests.swift
//  Syte_Tests
//
//  Created by Artur Tarasenko on 07.10.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import Syte

class LoggerTests: BaseTests {

    func testLogger() throws {
        SyteLogger.logLevel = .verbose
        XCTAssertEqual(SyteLogger.logLevel, .verbose)
        SyteLogger.v(tag: "test", message: "testMessageVerbose")
        SyteLogger.i(tag: "test", message: "testMessageVerbose")
        SyteLogger.d(tag: "test", message: "testMessageVerbose")
        SyteLogger.w(tag: "test", message: "testMessageVerbose")
        SyteLogger.e(tag: "test", message: "testMessageVerbose")
        
        SyteLogger.logLevel = .info
        XCTAssertEqual(SyteLogger.logLevel, .info)
        SyteLogger.v(tag: "test", message: "testMessageInfo")
        SyteLogger.i(tag: "test", message: "testMessageInfo")
        SyteLogger.d(tag: "test", message: "testMessageInfo")
        SyteLogger.w(tag: "test", message: "testMessageInfo")
        SyteLogger.e(tag: "test", message: "testMessageInfo")
        
        SyteLogger.logLevel = .debug
        XCTAssertEqual(SyteLogger.logLevel, .debug)
        SyteLogger.v(tag: "test", message: "testMessageInfoDebug")
        SyteLogger.i(tag: "test", message: "testMessageInfoDebug")
        SyteLogger.d(tag: "test", message: "testMessageInfoDebug")
        SyteLogger.w(tag: "test", message: "testMessageInfoDebug")
        SyteLogger.e(tag: "test", message: "testMessageInfoDebug")
        
        SyteLogger.logLevel = .warn
        XCTAssertEqual(SyteLogger.logLevel, .warn)
        SyteLogger.v(tag: "test", message: "testMessageInfoWarning")
        SyteLogger.i(tag: "test", message: "testMessageInfoWarning")
        SyteLogger.d(tag: "test", message: "testMessageInfoWarning")
        SyteLogger.w(tag: "test", message: "testMessageInfoWarning")
        SyteLogger.e(tag: "test", message: "testMessageInfoWarning")
        
        SyteLogger.logLevel = .error
        XCTAssertEqual(SyteLogger.logLevel, .error)
        SyteLogger.v(tag: "test", message: "testMessageInfoError")
        SyteLogger.i(tag: "test", message: "testMessageInfoError")
        SyteLogger.d(tag: "test", message: "testMessageInfoError")
        SyteLogger.w(tag: "test", message: "testMessageInfoError")
        SyteLogger.e(tag: "test", message: "testMessageInfoError")
    }

}
