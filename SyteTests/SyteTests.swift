import XCTest
@testable import Syte

class SyteTests: XCTestCase {
    
    var sut: SyteAI!

    override func setUp() {
        super.setUp()
        sut = SyteAI(accountID: "7300", token: "5ca6690b445ef77f87d3bbd5")
        sut.setDebugMode(true)
        
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSDK() {
        let expect = expectation(description: "getBoundsForImage")
        
        sut.getBoundsForImage(fromUrl: "http://wearesyte.com/syte_docs/images/1.jpeg",
                               feeds: ["general"],
                               success: { (bounds) in
                                XCTAssertEqual(bounds.count, 3, "Wrong bounds count")
                                
                                self.sut.getOffers(url: bounds[0].offers!, success: { (offerDetail) in
                                    XCTAssertEqual(offerDetail.ads.count, 50, "Wrong bounds count")
                                    expect.fulfill()
                                }, fail: { err in
                                    print(err)
                                })
        }, fail: { error in
            print(error)
        })
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

}
