//
//  ImageProcessor.swift
//  Syte
//
//  Created by Artur Tarasenko on 06.09.2021.
//

import Foundation
import PromiseKit

class ImageProcessor {
    
    private let tag = String(describing: ImageProcessor.self)
    
    public enum Scale {
        case small, medium, large
    }
    
    static let scaleQuality: Int = 20
    static let smallImageMaxSize: Int = 300
    static let smallImageMaxWidth: CGFloat = 500
    static let smallImageMaxHeight: CGFloat = 1000
    static let mediumImageMaxWidth: CGFloat = 1400
    static let mediumImageMaxHeight: CGFloat = 1400
    static let largeImageMaxWidth: CGFloat = 2000
    static let largeImageMaxHeight: CGFloat = 2000
    
    init() {}
    
    static func resize(image: UIImage, size: Int, scale: Scale) -> UIImage {
        var height: CGFloat = 0
        var width: CGFloat = 0
        let resultScale: Scale = size > smallImageMaxSize ? scale : .small
        
        switch resultScale {
        case .small:
            height = smallImageMaxHeight
            width = smallImageMaxWidth
        case .medium:
            height = mediumImageMaxHeight
            width = mediumImageMaxWidth
        case .large:
            height = largeImageMaxHeight
            width = largeImageMaxWidth
        }
        
        return resizeImage(image, to: CGSize(width: width, height: height))
    }
    
    static func compressToDataWithLoseQuality(image: UIImage, size: Int, scale: Scale) -> Promise<Data?> {
        Promise { seal in
            let compressed = resize(image: image, size: size, scale: scale)
            let compressedJpegData = UIImageJPEGRepresentation(compressed, 1)
            guard compressed.getImageSizeInKbAsJpeg() > smallImageMaxSize else { seal.fulfill(compressedJpegData); return }
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
    
    static func compressToDataWithLoseResolution(image: UIImage, size: Int, scale: Scale) -> Promise<Data?> {
        Promise { seal in
            let compressed = resize(image: image, size: size, scale: scale)
            guard compressed.getImageSizeInKbAsJpeg() > smallImageMaxSize else { seal.fulfill(UIImageJPEGRepresentation(compressed, 1)); return }
            DispatchQueue.global(qos: .userInitiated).async {
                
                guard let currentImageSize = UIImageJPEGRepresentation(image, 1.0)?.count else {
                    return seal.fulfill(nil)
                }
                let maxByte = smallImageMaxSize * 1000
                var iterationImage: UIImage? = image
                var iterationImageData: Data?
                var iterationImageSize = currentImageSize
                var iterationCompression: CGFloat = 1.0
                
                while iterationImageSize > maxByte && iterationCompression > 0.01 {
                    let percantageDecrease = getPercantageToDecreaseTo(forDataCount: iterationImageSize)
                    
                    let canvasSize = CGSize(width: image.size.width * iterationCompression,
                                            height: image.size.height * iterationCompression)
                    UIGraphicsBeginImageContextWithOptions(canvasSize, false, image.scale)
                    defer { UIGraphicsEndImageContext() }
                    image.draw(in: CGRect(origin: .zero, size: canvasSize))
                    iterationImage = UIGraphicsGetImageFromCurrentImageContext()
                    
                    guard let iterationImg = iterationImage,
                          let newImage = UIImageJPEGRepresentation(iterationImg, 1.0) else {
                        return seal.fulfill(nil)
                    }
                    iterationImageSize = newImage.count
                    iterationCompression -= percantageDecrease
                    iterationImageData = newImage
                }
                seal.fulfill(iterationImageData)
            }
        }
    }
    
    private static func getPercantageToDecreaseTo(forDataCount dataCount: Int) -> CGFloat {
        switch dataCount {
        case 0..<3000000:
            return 0.05
        case 3000000..<10000000:
            return 0.1
        default:
            return 0.2
        }
    }
    
    static func resizeImage(_ image: UIImage, to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 1.0)
        defer { UIGraphicsEndImageContext() }
        
        image.draw(in: CGRect(origin: CGPoint.zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext() ?? image
    }
    
    static func getMeta(image: UIImage) {
        guard let data = UIImageJPEGRepresentation(image, 1),
              let source = CGImageSourceCreateWithData(data as CFData, nil) else { return}
        let metadata = CGImageSourceCopyPropertiesAtIndex(source, 0, nil)
        print("LOG: \n\(String(describing: metadata))")
    }
    
}
