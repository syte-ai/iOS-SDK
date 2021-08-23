//
//  ImageSearch.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.08.2021.
//

import Foundation

public class ImageSearch {
    
    private var imageUri: String
    private var coordinates: CropCoordinates?
    private var retrieveOffersForTheFirstBound = true
    private var personalizedRanking = false
    
    public init(uri: String) {
        imageUri = uri
    }
    
    public func getImageUri() -> String {
        return imageUri
    }
    
    public func setFirstBoundItemsCoordinates(coordinates: CropCoordinates) {
        self.coordinates = coordinates
    }
    
    public func getFirstBoundItemsCoordinates() -> CropCoordinates? {
        return coordinates
    }
    
    public func setRetrieveItemsForTheFirstBound(retrieveItemsForTheFirstBound: Bool) {
        retrieveOffersForTheFirstBound = retrieveItemsForTheFirstBound
    }
    
    public func isRetrieveItemsForTheFirstBound() -> Bool {
        return retrieveOffersForTheFirstBound
    }
    
    public func setPersonalizedRanking(personalizedRanking: Bool) {
        self.personalizedRanking = personalizedRanking
    }
    
    public func getPersonalizedRanking() -> Bool {
        return personalizedRanking
    }
    
}
