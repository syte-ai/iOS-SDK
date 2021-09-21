//
//  ProductRecommendationClient.swift
//  Syte
//
//  Created by Artur Tarasenko on 17.09.2021.
//

import Foundation
import PromiseKit

class ProductRecommendationClient {
    
    private let syteRemoteDataSource: SyteRemoteDataSource
    private let sytePlatformSettings: SytePlatformSettings
    
    init(syteRemoteDataSource: SyteRemoteDataSource, sytePlatformSettings: SytePlatformSettings) {
        self.sytePlatformSettings = sytePlatformSettings
        self.syteRemoteDataSource = syteRemoteDataSource
    }
    
    func getSimilarProducts(similarProducts: SimilarProducts, completion: @escaping (SyteResult<SimilarProductsResult>) -> Void) {
        do {
            try InputValidator.validateInput(requestData: similarProducts)
            syteRemoteDataSource.getSimilarProducts(similarProducts: similarProducts, completion: completion)
        } catch let error {
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    func getShopTheLook(shopTheLook: ShopTheLook, completion: @escaping (SyteResult<ShopTheLookResult>) -> Void) {
        do {
            try InputValidator.validateInput(requestData: shopTheLook)
            syteRemoteDataSource.getShopTheLook(shopTheLook: shopTheLook, settings: sytePlatformSettings, completion: completion)
        } catch let error {
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    func getPersonalization(personalization: Personalization, completion: @escaping (SyteResult<PersonalizationResult>) -> Void) {
        syteRemoteDataSource.getPersonalization(personalization: personalization, completion: completion)
    }
    
}
