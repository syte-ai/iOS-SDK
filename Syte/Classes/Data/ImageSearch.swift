//
//  ImageSearch.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

public class ImageSearch {
    
    private(set) var imageUri: String
    public var coordinates: CropCoordinates?
    public var retrieveOffersForTheFirstBound = true
    public var personalizedRanking = false
    
    public init(uri: String) {
        imageUri = uri
    }
    
}
