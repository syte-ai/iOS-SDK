//
//  SyteResultTests.swift
//  Syte_Tests
//
//  Created by Artur Tarasenko on 08.10.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import Syte

class SyteResultTests: XCTestCase {

    func testSyteResult() throws {
        let boolResultSuccess: SyteResult<Bool> = .successResult
        let boolResultFailure: SyteResult<Bool> = .failureResult(message: "Fail")
        XCTAssertNotNil(boolResultSuccess.data)
        XCTAssertTrue(boolResultSuccess.data!)
        XCTAssertNotNil(boolResultFailure.data)
        XCTAssertFalse(boolResultFailure.data!)
        XCTAssertEqual(boolResultFailure.errorMessage, "Fail")
        
        let errorGeneral: SyteError = .generalError(message: "General")
        let errorInput: SyteError = .wrongInput(message: "Input")
        XCTAssertEqual(errorGeneral.localizedDescription, "General")
        XCTAssertEqual(errorInput.localizedDescription, "Input")
    }

}
