//
//  JSONValue.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public enum JSONValue: Codable {
    
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case object([String: JSONValue])
    case array([JSONValue])
    
    public func values() -> AnyObject {
        switch self {
        case .string(let s):
            return s as AnyObject
        case .int(let i):
            return i as AnyObject
        case .double(let d):
            return d as AnyObject
        case .bool(let b):
            return b as AnyObject
        case .object(let xs):
            return xs.mapValues { $0.values() } as AnyObject
        case .array(let xs):
            return xs.map { $0.values() } as AnyObject
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = try ((try? container.decode(String.self)).map(JSONValue.string))
            .or((try? container.decode(Int.self)).map(JSONValue.int))
            .or((try? container.decode(Double.self)).map(JSONValue.double))
            .or((try? container.decode(Bool.self)).map(JSONValue.bool))
            .or((try? container.decode([String: JSONValue].self)).map(JSONValue.object))
            .or((try? container.decode([JSONValue].self)).map(JSONValue.array))
            .resolve(with: DecodingError.typeMismatch(JSONValue.self,
                                                      DecodingError.Context(codingPath: container.codingPath,
                                                                            debugDescription: "Not a JSON")))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let string):
            try container.encode(string)
        case .bool(let bool):
            try container.encode(bool)
        case .array(let array):
            try container.encode(array)
        case .object(let object):
            try container.encode(object)
        case .int(let int):
            try container.encode(int)
        case .double(let double):
            try container.encode(double)
        }
    }
    
}
