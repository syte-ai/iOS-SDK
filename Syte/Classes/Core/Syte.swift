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
    
    /**
     Set/Get log level.
     */
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
    
    /**
     Creates a new instance of the `Syte` class and triggers the start session call.
     
     - Returns: A new instance of the `Syte`.
     */
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
    
    /**
     Retrieves items: Get similar items per bounding box detected in the image.
     
     - parameters:
        - bound: The list of detected Bounds can be retrieved from the result of getBounds call.
        - cropCoordinates: Pass crop coordinates to enable image cropping. Pass nil to disregard crop.
        - completion: `SyteResult<ItemsResult>`.
     */
    public func getItemsForBound(bound: Bound, cropCoordinates: CropCoordinates?, completion: @escaping (SyteResult<ItemsResult>) -> Void) {
        do {
            try verifyInitialized()
            guard let client = imageSearchClient else { return completion(.syteNotInilialized) }
            client.getItemsForBound(bound: bound, cropCoordinates: cropCoordinates, completion: completion)
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    /**
     Retrieves bounds: Returns a list of all objects (bounds) detected in the image. Each bound includes the category name it belongs to and the coordinates (x,y) of the object.
     
     - parameters:
        - imageSearch: `ImageSearch`
        - completion: `SyteResult<BoundsResult>`.
     */
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
    
    /**
     Retrieves bounds: Returns a list of all objects (bounds) detected in the image. Each bound includes the category name it belongs to and the coordinates (x,y) of the object.
     
     - parameters:
        - imageSearch: `UrlImageSearch`
        - completion: `SyteResult<BoundsResult>`.
     */
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
    
    /**
     Make 'Similars' call: Receives a product SKU and returns a list of similar products.
     
     - parameters:
        - similarProducts: `SimilarProducts`
        - completion: `SyteResult<SimilarProductsResult>`.
     */
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
    
    /**
     Make 'Shop the look' call: Receives a product SKU and returns a list of similar products for all the items in the image (besides the PDP item).
     
     - parameters:
        - shopTheLook: `ShopTheLook`
        - completion: `SyteResult<ShopTheLookResult>`.
     */
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
    
    /**
     Make 'Personalization' call: Receives a list of visited SKUs and the current SKU, the engine will return a list of recommended products for this user, according to the defined model for the account.
     
     - parameters:
        - personalization: `Personalization`
        - completion: `SyteResult<PersonalizationResult>`.
     */
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
    
    /**
     Retrieves the most popular searches for the specified language.
     
     - parameters:
        - lang: Locale to retrieve the searches for.
        - completion: `SyteResult<[String]>`.
     */
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

    /**
     Retrieves the text search results.
     
     - parameters:
        - textSearch: query parameters `TextSearch`.
        - completion: `SyteResult<TextSearchResult>`.
     */
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
    
    /**
     Retrieves Auto-complete results. Will use the locale set in `SyteConfiguration`.
     There must be at least 500ms interval between calls to this method.
     
     - Note:
     Otherwise there are two options:
     1. If SyteConfiguration.setAllowAutoCompletionQueue is set to true, the last request data will be saved in a queue and the
     request will be fired after 500ms.
     2. If SyteConfiguration.setAllowAutoCompletionQueue is set to false, the calls to this method made within 500ms will be ignored.
     
     - Parameters:
        - query: Text query.
        - lang: Locale to retrieve the searches for.
        - completion: `SyteResult<AutoCompleteResult>`.
     */
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
    
    /**
     Retrieve current configuration.
     
     - Returns: `SyteConfiguration`.
     
     */
    public func getConfiguration() -> SyteConfiguration? {
        return configuration
    }
    
    /**
     Apply new configuration
     
     - Parameter configuration: SyteConfiguration
     
     - Throws: `SyteError.initializationFailed`
     
     */
    public func setConfiguration(configuration: SyteConfiguration) throws {
        try verifyInitialized()
        self.configuration = configuration
        syteRemoteDataSource.setConfiguration(configuration)
        eventsRemoteDataSource.setConfiguration(configuration)
        textSearchClient?.allowAutoCompletionQueue = configuration.allowAutoCompletionQueue
        
    }
    
    /**
     Getter for SytePlatformSettings. Method will return nil if the session was not started!
     
     - Returns: `SytePlatformSettings`.
     */
    public func getSytePlatformSettings() -> SytePlatformSettings? {
        return state == .initialized ? sytePlatformSettings : nil
    }
    
    /**
     Send event to Syte. Can be used to send either predefined events or a custom event.
     
     - Parameter event: Extend `BaseSyteEvent` to send custom events.
     - Throws: `SyteError.initializationFailed`
     
     */
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
    
    /**
     Save product ID into the local storage. All saved viewed products will be used for personalization.
     
     - Parameter sku: Product ID.
     - Throws: `SyteError.initializationFailed`
     
     */
    public func addViewedItem(sku: String) throws {
        try verifyInitialized()
        try InputValidator.validateInput(string: sku)
        configuration.addViewedProduct(sessionSku: sku)
    }
    
    /**
     Get all product IDs that were viewed during this session.
     
     - Returns: list of product IDs.
     - Throws: `SyteError.initializationFailed`
     
     */
    public func getViewedProducts() -> Set<String> {
        return configuration.getViewedProducts()
    }
    
    /**
     Retrieves the list of recent text searches.
     
     - Returns: list of recent text searches.
     - Note: searches with no results will not be saved.
     
     */
    public func getRecentTextSearches() -> [String] {
        let terms = configuration.getStorage().getTextSearchTerms()
        return terms.components(separatedBy: ",")
    }
    
    private func startSession(completion: @escaping (SyteResult<Bool>) -> Void) {
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
    
    private func verifyInitialized() throws {
        guard state == .initialized else { throw SyteError.initializationFailed(message: "Syte is not initialized.")}
    }
    
}
