//
//  Data + Extension.swift
//  Syte
//
//  Created by Artur Tarasenko on 08.09.2021.
//

import Foundation

extension Data {
    
    func getSizeInKB() -> Int {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useKB
        formatter.countStyle = ByteCountFormatter.CountStyle.file

        return Int(Int64(count) / 1024)
    }
    
}
