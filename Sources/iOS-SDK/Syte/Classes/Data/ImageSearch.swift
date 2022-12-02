//
//  ImageSearch.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

/**
 Class that is used to configure the 'wild' image search.
 */
public class ImageSearch {
    
    /// User generated image
    private(set) var image: UIImage
    
    /// The crop coordinates of the item, should be relative ranging from 0.0 to 1.0
    public var coordinates: CropCoordinates?
    
    /// Items for the first bound will be retrieved by default
    public var retrieveOffersForTheFirstBound = true
    
    /// Enabling the personalized ranking will use the list of viewed products (skus viewed during the session) and apply a behavioral match ranking strategy on the set of results.
    public var personalizedRanking = false
    
    /// User generated image will be scaled according to this value.
    /// Small - width: 500, height: 1000
    /// Medium - width: 1400, height: 1400
    /// Large - width: 2000, height: 2000
    public var scale: ImageScale = .medium
    
    public init(image: UIImage) {
        self.image = image
    }
    
}
