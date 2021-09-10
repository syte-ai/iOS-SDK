//
//  UIImage + Extensions.swift
//  Syte
//
//  Created by Artur Tarasenko on 06.09.2021.
//

import Foundation

extension UIImage {
    
    func getImageSizeInKbAsJpeg() -> Int {
        guard let data = UIImageJPEGRepresentation(self, 1) else { return -1 }
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useKB
        formatter.countStyle = ByteCountFormatter.CountStyle.file
        let imageSize = formatter.string(fromByteCount: Int64(data.count))
        print("ImageSize(KB): \(imageSize)")
        return Int(Int64(data.count) / 1024)
    }
    
}
