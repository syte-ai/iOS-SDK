//
//  ImageSearchClient.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation
import PromiseKit

class ImageSearchClient {
    
    private let syteRemoteDataSource: SyteRemoteDataSource
    
    init(syteRemoteDataSource: SyteRemoteDataSource) {
        self.syteRemoteDataSource = syteRemoteDataSource
    }
    
    public func getBounds(requestData: UrlImageSearch, completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        do {
            try InputValidator.validateInput(requestData: requestData)
            syteRemoteDataSource.getBounds(requestData: requestData, completion: completion)
        } catch let error {
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getBounds(requestData: ImageSearch, completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        syteRemoteDataSource.getBoundsWild(requestData: requestData, completion: completion)
    }
    
    public func getItemsForBound(bound: Bound, cropCoordinates: CropCoordinates?, completion: @escaping (SyteResult<ItemsResult>) -> Void) {
        guard let offersUrl = bound.offersUrl else { completion(.failureResult(message: "Empty offers url.")); return }
        syteRemoteDataSource.getOffers(offersUrl: offersUrl,
                                       crop: cropCoordinates,
                                       completion: completion)
    }
    
}
