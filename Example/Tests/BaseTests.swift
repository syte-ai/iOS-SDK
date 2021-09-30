import XCTest
import Syte

class BaseTests: XCTestCase {
    
    var syte: Syte?
    var configuration: SyteConfiguration?
    
    override func setUp() {
        super.setUp()
        let expectation = XCTestExpectation(description: "Syte should be initialized")
        let configurationValue = SyteConfiguration(accountId: "9165", signature: "601c206d0a7f780efb9360f3")
        configuration = configurationValue
        Syte.initialize(configuration: configurationValue) { [weak self] result in
            self?.syte = result.data
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    override func tearDown() {
        super.tearDown()
        syte = nil
        configuration = nil
    }
    
}
