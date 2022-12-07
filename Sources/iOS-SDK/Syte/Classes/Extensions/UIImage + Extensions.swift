//
//  UIImage + Extensions.swift
//  Syte
//
//  Created by Artur Tarasenko on 06.09.2021.
//

import Foundation
import UIKit

extension UIImage {
    
    func getImageSizeInKbAsJpeg() -> Int {
        guard let data = self.jpegData(compressionQuality: 1) else { return -1 }
        
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useKB
        formatter.countStyle = ByteCountFormatter.CountStyle.file
        
        return Int(Int64(data.count) / 1024)
    }
    
}
