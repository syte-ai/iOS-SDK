import XCTest
@testable import Syte

class BaseTests: XCTestCase {
    
    let syte: Syte = {
        let syteVar = Syte(configuration: SyteConfiguration(accountId: "9165", signature: "601c206d0a7f780efb9360f3"))
        XCTAssertNotNil(syteVar)
        return syteVar!
    }()
    
    override func setUp() {
        super.setUp()
    }
    
}
