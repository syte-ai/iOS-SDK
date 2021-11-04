//
//  ImageProcessorTests.swift
//  Syte_Tests
//
//  Created by Artur Tarasenko on 08.10.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import Syte

class ImageProcessorTests: XCTestCase {

    func testImageProcessor() throws {
        _ = ImageProcessor.resize(image: UIImage(), size: 500, scale: .small)
        _ = ImageProcessor.resize(image: UIImage(), size: 500, scale: .medium)
        _ = ImageProcessor.resize(image: UIImage(), size: 500, scale: .large)
    }

}
