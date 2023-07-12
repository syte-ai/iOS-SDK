//
//  ReflectedStringConvertible + Extension.swift
//  Syte
//
//  Created by Artur Tarasenko on 31.08.2021.
//

import Foundation

public protocol ReflectedStringConvertible: CustomStringConvertible { }

extension ReflectedStringConvertible {
    
    public var description: String {
        let mirror = Mirror(reflecting: self)
        
        var str = "\(mirror.subjectType)("
        var first = true
        for (label, value) in mirror.children {
            guard let label = label else { continue }
            first ? (first = false) : (str += ", ")
                
                str += label
                str += ": "
                if Mirror.isOptional(any: value) {
                    var stringValue = "\(value)".replacingOccurrences(of: "Optional(", with: "")
                    stringValue.removeLast()
                    str += "\(stringValue)"
                } else {
                    str += "\(value)"
                }
            
        }
        str += ")"
        
        return str
    }
    
}

extension Mirror {
    
    static func isOptional(any: Any) -> Bool {
        guard let style = Mirror(reflecting: any).displayStyle, style == .optional else { return false }
        return true
    }
    
}
