//
//  Syte.swift
//  Syte
//
//  Created by Artur Tarasenko on 18.08.2021.
//  Copyright © 2021 Syte.ai. All rights reserved.
//

import Foundation
import PromiseKit

public final class Syte {
    
    // MARK: Private properties
    
    private static let tag = String(describing: Syte.self)
    
    private enum SyteState {
        case idle, initialized
    }
    
    private var configuration: SyteConfiguration
    
    private let syteRemoteDataSource: SyteRemoteDataSource
    private let eventsRemoteDataSource: EventsRemoteDataSource
    private var sytePlatformSettings: SytePlatformSettings?
    private var imageSearchClient: ImageSearchClient?
    private var productRecommendationClient: ProductRecommendationClient?
    private var state = SyteState.idle
    
    // MARK: Public properties
    
    public var logLevel: SyteLogger.LogLevel {
        get {
            return SyteLogger.getLogLevel()
        }
        set {
            SyteLogger.setLogLevel(newValue)
        }
    }
    
    private init(configuration: SyteConfiguration) {
        self.configuration = configuration
        syteRemoteDataSource = SyteRemoteDataSource(configuration: configuration)
        eventsRemoteDataSource = EventsRemoteDataSource(configuration: configuration)
    }
    
    public static func initialize(configuration: SyteConfiguration, completion: @escaping (SyteResult<Syte>) -> Void) {
        do {
            try InputValidator.validateInput(configuration: configuration)
            
            let syte = Syte(configuration: configuration)
            syte.startSession { syteResult in
                let result = SyteResult<Syte>()
                result.resultCode = syteResult.resultCode
                result.errorMessage = syteResult.errorMessage
                result.isSuccessful = syteResult.isSuccessful
                result.data = syteResult.isSuccessful ? syte : nil
                completion(result)
            }
            
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    func startSession(completion: @escaping (SyteResult<Bool>) -> Void) {
        syteRemoteDataSource.initialize { [weak self] response in
            guard let strongSelf = self else { completion(.failureResult(message: "Can't fetch syte platform settings.")); return }
            if response.isSuccessful {
                guard let settings = response.data else { completion(.failureResult(message: "Can't fetch syte platform settings.")); return }
                strongSelf.sytePlatformSettings = settings
                strongSelf.imageSearchClient = ImageSearchClient(syteRemoteDataSource: strongSelf.syteRemoteDataSource,
                                                                 sytePlatformSettings: settings)
                strongSelf.productRecommendationClient = ProductRecommendationClient(syteRemoteDataSource: strongSelf.syteRemoteDataSource,
                                                                                     sytePlatformSettings: settings)
                strongSelf.state = .initialized
                strongSelf.fire(event: EventInitialization())
            } else {
                strongSelf.state = .idle
            }
            let result = SyteResult<Bool>()
            result.data = response.isSuccessful
            result.resultCode = response.resultCode
            result.isSuccessful = response.isSuccessful
            result.errorMessage = response.errorMessage
            completion(result)
        }
    }
    
    public func getItemsForBound(bound: Bound, cropCoordinates: CropCoordinates, completion: @escaping (SyteResult<ItemsResult>) -> Void) {
        do {
            try verifyInitialized()
            guard let client = imageSearchClient else { completion(.syteNotInilialized); return }
            client.getItemsForBound(bound: bound, cropCoordinates: cropCoordinates, completion: completion)
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getBounds(imageSearch: ImageSearch, completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        do {
            try verifyInitialized()
            guard let client = imageSearchClient else { completion(.syteNotInilialized); return }
            client.getBounds(requestData: imageSearch, completion: completion)
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getBounds(imageSearch: UrlImageSearch, completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        do {
            try verifyInitialized()
            guard let client = imageSearchClient else { completion(.syteNotInilialized); return }
            client.getBounds(requestData: imageSearch, completion: completion)
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getSimilarProducts(similarProducts: SimilarProducts, completion: @escaping (SyteResult<SimilarProductsResult>) -> Void) {
        do {
            try verifyInitialized()
            guard let client = productRecommendationClient else { completion(.syteNotInilialized); return }
            client.getSimilarProducts(similarProducts: similarProducts, completion: completion)
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getShopTheLook(shopTheLook: ShopTheLook, completion: @escaping (SyteResult<ShopTheLookResult>) -> Void) {
        do {
            try verifyInitialized()
            guard let client = productRecommendationClient else { completion(.syteNotInilialized); return }
            client.getShopTheLook(shopTheLook: shopTheLook, completion: completion)
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getPersonalization(personalization: Personalization, completion: @escaping (SyteResult<PersonalizationResult>) -> Void) {
        do {
            try verifyInitialized()
            guard let client = productRecommendationClient else { completion(.syteNotInilialized); return }
            client.getPersonalization(personalization: personalization, completion: completion)
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getConfiguration() -> SyteConfiguration? {
        return configuration
    }
    
    public func setConfiguration(configuration: SyteConfiguration) throws {
        try verifyInitialized()
        self.configuration = configuration
        
    }
    
    public func getSytePlatformSettings() -> SytePlatformSettings? {
        return state == .initialized ? sytePlatformSettings : nil
    }
    
    public func fire(event: BaseSyteEvent) {
        do {
            try verifyInitialized()
            eventsRemoteDataSource.fire(event: event)
            if event is EventPageView {
                let casted = event as? EventPageView
                try? addViewedItem(sku: casted?.sku ?? "")
            }
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: "Error while firing event: \(error.localizedDescription)")
        }
    }
    
    public func addViewedItem(sku: String) throws {
        try verifyInitialized()
        try InputValidator.validateInput(string: sku)
        configuration.addViewedProduct(sessionSku: sku)
    }
    
    public func getViewedProducts() -> Set<String> {
        return configuration.getViewedProducts()
    }
    
    private func verifyInitialized() throws {
        guard state == .initialized else { throw SyteError.initializationFailed(message: "Syte is not initialized.")}
    }
    
}
