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
    private var textSearchClient: TextSearchClient?
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
                completion(syteResult.mapData { $0.isSuccessful ? syte : nil})
            }
            
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    func startSession(completion: @escaping (SyteResult<Bool>) -> Void) {
        syteRemoteDataSource.initialize { [weak self] response in
            guard let strongSelf = self else { return completion(.failureResult(message: "Can't fetch syte platform settings.")) }
            if response.isSuccessful {
                guard let settings = response.data else { return completion(.failureResult(message: "Can't fetch syte platform settings.")) }
                strongSelf.sytePlatformSettings = settings
                strongSelf.imageSearchClient = ImageSearchClient(syteRemoteDataSource: strongSelf.syteRemoteDataSource,
                                                                 sytePlatformSettings: settings)
                strongSelf.productRecommendationClient = ProductRecommendationClient(syteRemoteDataSource: strongSelf.syteRemoteDataSource,
                                                                                     sytePlatformSettings: settings)
                strongSelf.textSearchClient = TextSearchClient(syteRemoteDataSource: strongSelf.syteRemoteDataSource,
                                                               allowAutoCompletionQueue: strongSelf.configuration.allowAutoCompletionQueue)
                strongSelf.state = .initialized
                strongSelf.fire(event: EventInitialization())
            } else {
                strongSelf.state = .idle
            }
            completion(response.mapData { $0.isSuccessful })
        }
    }
    
    public func getItemsForBound(bound: Bound, cropCoordinates: CropCoordinates, completion: @escaping (SyteResult<ItemsResult>) -> Void) {
        do {
            try verifyInitialized()
            guard let client = imageSearchClient else { return completion(.syteNotInilialized) }
            client.getItemsForBound(bound: bound, cropCoordinates: cropCoordinates, completion: completion)
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getBounds(imageSearch: ImageSearch, completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        do {
            try verifyInitialized()
            guard let client = imageSearchClient else { return completion(.syteNotInilialized) }
            client.getBounds(requestData: imageSearch, completion: completion)
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getBounds(imageSearch: UrlImageSearch, completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        do {
            try verifyInitialized()
            guard let client = imageSearchClient else { return completion(.syteNotInilialized) }
            client.getBounds(requestData: imageSearch, completion: completion)
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getSimilarProducts(similarProducts: SimilarProducts, completion: @escaping (SyteResult<SimilarProductsResult>) -> Void) {
        do {
            try verifyInitialized()
            guard let client = productRecommendationClient else { return completion(.syteNotInilialized) }
            client.getSimilarProducts(similarProducts: similarProducts, completion: completion)
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getShopTheLook(shopTheLook: ShopTheLook, completion: @escaping (SyteResult<ShopTheLookResult>) -> Void) {
        do {
            try verifyInitialized()
            guard let client = productRecommendationClient else { return completion(.syteNotInilialized) }
            client.getShopTheLook(shopTheLook: shopTheLook, completion: completion)
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getPersonalization(personalization: Personalization, completion: @escaping (SyteResult<PersonalizationResult>) -> Void) {
        do {
            try verifyInitialized()
            guard let client = productRecommendationClient else { return completion(.syteNotInilialized) }
            client.getPersonalization(personalization: personalization, completion: completion)
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getAutoComplete(query: String, lang: String?, completion: @escaping (SyteResult<AutoCompleteResult>) -> Void) {
        do {
            try verifyInitialized()
            guard let client = textSearchClient else { return completion(.syteNotInilialized) }
            client.getAutoComplete(query: query, lang: lang ?? configuration.locale, completion: completion)
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getPopularSearch(lang: String, completion: @escaping (SyteResult<[String]>) -> Void) {
        do {
            try verifyInitialized()
            guard let client = textSearchClient else { return completion(.syteNotInilialized) }
            client.getPopularSearch(lang: lang, completion: completion)
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getTextSearch(textSearch: TextSearch, completion: @escaping (SyteResult<TextSearchResult>) -> Void) {
        do {
            try verifyInitialized()
            guard let client = textSearchClient else { return completion(.syteNotInilialized) }
            client.getTextSearch(textSearch: textSearch, completion: completion)
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
        syteRemoteDataSource.setConfiguration(configuration)
        eventsRemoteDataSource.setConfiguration(configuration)
        textSearchClient?.allowAutoCompletionQueue = configuration.allowAutoCompletionQueue
        
    }
    
    public func getSytePlatformSettings() -> SytePlatformSettings? {
        return state == .initialized ? sytePlatformSettings : nil
    }
    
    public func fire(event: BaseSyteEvent) {
        do {
            try verifyInitialized()
            eventsRemoteDataSource.fire(event: event)
            if let casted = event as? EventPageView {
                try? addViewedItem(sku: casted.sku)
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
    
    public func getRecentTextSearches() -> [String] {
        let terms = configuration.getStorage().getTextSearchTerms()
        return terms.components(separatedBy: ",")
    }
    
    private func verifyInitialized() throws {
        guard state == .initialized else { throw SyteError.initializationFailed(message: "Syte is not initialized.")}
    }
    
}
