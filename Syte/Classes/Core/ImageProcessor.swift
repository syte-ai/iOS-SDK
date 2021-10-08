//
//  ImageProcessor.swift
//  Syte
//
//  Created by Artur Tarasenko on 06.09.2021.
//

import Foundation
import PromiseKit

class ImageProcessor {
    
    static let scaleQuality: Int = 20
    static let smallImageMaxSize: Int = 300
    static let smallSize = CGSize(width: 500, height: 1000)
    static let mediumSize = CGSize(width: 1400, height: 1400)
    static let largeSize = CGSize(width: 2000, height: 2000)
    
    static func resize(image: UIImage, size: Int, scale: ImageScale) -> UIImage {
        var sizeResult = CGSize()
        let resultScale: ImageScale = size > smallImageMaxSize ? scale : .small
        
        switch resultScale {
        case .small:
            sizeResult = smallSize
        case .medium:
            sizeResult = mediumSize
        case .large:
            sizeResult = largeSize
        }
        
        return resizeImage(image, to: sizeResult)
    }
    
    static func compressToDataWithLoseQuality(image: UIImage, size: Int, scale: ImageScale) -> Promise<Data?> {
        Promise { seal in
            let compressed = resize(image: image, size: size, scale: scale)
            let compressedJpegData = UIImageJPEGRepresentation(compressed, 1)
            guard compressed.getImageSizeInKbAsJpeg() > smallImageMaxSize else { return seal.fulfill(compressedJpegData) }
            guard let currentImageSize = compressedJpegData?.count else { return seal.fulfill(nil) }
            
            let maxByte = smallImageMaxSize * 1000
            var iterationImageData: Data?
            var iterationImageSize = currentImageSize
            
            var iterationCompression: CGFloat = 1.0
            let step: CGFloat = 0.1
            
            while iterationImageSize > maxByte && iterationCompression > 0.2 {
                guard iterationCompression > 0.2,
                      let newImage = UIImageJPEGRepresentation(compressed, iterationCompression) else { return seal.fulfill(nil) }
                iterationImageSize = newImage.count
                iterationCompression -= step
                iterationImageData = newImage
            }
            seal.fulfill(iterationImageData)
        }
    }
    
    static func resizeImage(_ image: UIImage, to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 1.0)
        defer { UIGraphicsEndImageContext() }
        
        image.draw(in: CGRect(origin: CGPoint.zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext() ?? image
    }
    
}
