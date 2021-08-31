//
//  ProductCard.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class ProductCard: Codable, ReflectedStringConvertible {
    
    public var ratings: Ratings?
    public var addToCart: AddToCart?
    
}
