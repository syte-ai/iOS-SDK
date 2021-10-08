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
    
    private var configuration: SyteConfiguration
    
    private let syteRemoteDataSource: SyteRemoteDataSource
    private let eventsRemoteDataSource: EventsRemoteDataSource
    private var imageSearchClient: ImageSearchClient
    private var productRecommendationClient: ProductRecommendationClient
    private var textSearchClient: TextSearchClient
    
    /**
     Set/Get log level.
     */
    public var logLevel: SyteLogger.LogLevel {
        get {
            return SyteLogger.logLevel
        }
        set {
            SyteLogger.logLevel = newValue
        }
    }
    
    public init?(configuration: SyteConfiguration) {
        do {
            try InputValidator.validateInput(configuration: configuration)
            
            self.configuration = configuration
            syteRemoteDataSource = SyteRemoteDataSource(configuration: configuration)
            eventsRemoteDataSource = EventsRemoteDataSource(configuration: configuration)
            imageSearchClient = ImageSearchClient(syteRemoteDataSource: syteRemoteDataSource)
            productRecommendationClient = ProductRecommendationClient(syteRemoteDataSource: syteRemoteDataSource)
            textSearchClient = TextSearchClient(syteRemoteDataSource: syteRemoteDataSource,
                                                allowAutoCompletionQueue: configuration.allowAutoCompletionQueue)
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            return nil
        }
    }
    
    /**
     Retrieves items: Get similar items per bounding box detected in the image.
     
     - parameters:
        - bound: The list of detected Bounds can be retrieved from the result of getBounds call.
        - cropCoordinates: Pass crop coordinates to enable image cropping. Pass nil to disregard crop.
        - completion: `SyteResult<ItemsResult>`.
     */
    public func getItemsForBound(bound: Bound,
                                 cropCoordinates: CropCoordinates?,
                                 completion: @escaping (SyteResult<ItemsResult>) -> Void) {
        imageSearchClient.getItemsForBound(bound: bound, cropCoordinates: cropCoordinates, completion: completion)
    }
    
    /**
     Retrieves bounds: Returns a list of all objects (bounds) detected in the image. Each bound includes the category name it belongs to and the coordinates (x,y) of the object.
     
     - parameters:
        - imageSearch: `ImageSearch`
        - completion: `SyteResult<BoundsResult>`.
     */
    public func getBoundsForImage(imageSearch: ImageSearch, completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        imageSearchClient.getBounds(requestData: imageSearch, completion: completion)
        
    }
    
    /**
     Retrieves bounds: Returns a list of all objects (bounds) detected in the image. Each bound includes the category name it belongs to and the coordinates (x,y) of the object.
     
     - parameters:
        - imageSearch: `UrlImageSearch`
        - completion: `SyteResult<BoundsResult>`.
     */
    public func getBoundsForImageUrl(imageSearch: UrlImageSearch, completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        imageSearchClient.getBounds(requestData: imageSearch, completion: completion)
    }
    
    /**
     Make 'Similars' call: Receives a product SKU and returns a list of similar products.
     
     - parameters:
        - similarProducts: `SimilarProducts`
        - completion: `SyteResult<SimilarProductsResult>`.
     */
    public func getSimilarProducts(similarProducts: SimilarProducts,
                                   completion: @escaping (SyteResult<SimilarProductsResult>) -> Void) {
        productRecommendationClient.getSimilarProducts(similarProducts: similarProducts, completion: completion)
        
    }
    
    /**
     Make 'Shop the look' call: Receives a product SKU and returns a list of similar products for all the items in the image (besides the PDP item).
     
     - parameters:
        - shopTheLook: `ShopTheLook`
        - completion: `SyteResult<ShopTheLookResult>`.
     */
    public func getShopTheLook(shopTheLook: ShopTheLook,
                               completion: @escaping (SyteResult<ShopTheLookResult>) -> Void) {
        productRecommendationClient.getShopTheLook(shopTheLook: shopTheLook, completion: completion)
    }
    
    /**
     Make 'Personalization' call: Receives a list of visited SKUs and the current SKU, the engine will return a list of recommended products for this user, according to the defined model for the account.
     
     - parameters:
        - personalization: `Personalization`
        - completion: `SyteResult<PersonalizationResult>`.
     */
    public func getPersonalization(personalization: Personalization,
                                   completion: @escaping (SyteResult<PersonalizationResult>) -> Void) {
        productRecommendationClient.getPersonalization(personalization: personalization, completion: completion)
    }
    
    /**
     Retrieves the most popular searches for the specified language.
     
     - parameters:
        - lang: Locale to retrieve the searches for.
        - completion: `SyteResult<[String]>`.
     */
    public func getPopularSearches(lang: String, completion: @escaping (SyteResult<[String]>) -> Void) {
        textSearchClient.getPopularSearch(lang: lang, completion: completion)
    }

    /**
     Retrieves the text search results.
     
     - parameters:
        - textSearch: query parameters `TextSearch`.
        - completion: `SyteResult<TextSearchResult>`.
     */
    public func getTextSearch(textSearch: TextSearch, completion: @escaping (SyteResult<TextSearchResult>) -> Void) {
        textSearchClient.getTextSearch(textSearch: textSearch, completion: completion)
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
    public func getAutoCompleteForTextSearch(query: String,
                                             lang: String?,
                                             completion: @escaping (SyteResult<AutoCompleteResult>) -> Void) {
        textSearchClient.getAutoComplete(query: query, lang: lang ?? configuration.locale, completion: completion)
    }
    
    /**
     Retrieves the Syte Platform Settings.
     
     - Parameter completion: `SyteResult<SytePlatformSettings>`.
     */
    public func getPlatformSettings(completion: @escaping (SyteResult<SytePlatformSettings>) -> Void) {
        syteRemoteDataSource.getSettings { response in
            guard response.isSuccessful else { return completion(.failureResult(message: "Can't fetch syte platform settings.")) }
            completion(response.mapData { $0.data })
        }
    }
    
    /**
     Retrieve current configuration.
     
     - Returns: `SyteConfiguration`.
     
     */
    public func getConfiguration() -> SyteConfiguration {
        return configuration
    }
    
    /**
     Apply new configuration
     
     - Parameter configuration: SyteConfiguration
     
     - Throws: `SyteError.initializationFailed`
     
     */
    public func setConfiguration(configuration: SyteConfiguration) {
        self.configuration = configuration
        syteRemoteDataSource.setConfiguration(configuration)
        eventsRemoteDataSource.setConfiguration(configuration)
        textSearchClient.allowAutoCompletionQueue = configuration.allowAutoCompletionQueue
        
    }
    
    /**
     Send event to Syte. Can be used to send either predefined events or a custom event.
     
     - Parameter event: Extend `BaseSyteEvent` to send custom events.
     - Throws: `SyteError.initializationFailed`
     
     */
    public func fire(event: BaseSyteEvent) {
        eventsRemoteDataSource.fire(event: event)
        if let casted = event as? EventPageView {
            try? addViewedProduct(sku: casted.sku)
        }
    }
    
    /**
     Save product ID into the local storage. All saved viewed products will be used for personalization.
     
     - Parameter sku: Product ID.
     - Throws: `SyteError.initializationFailed`
     
     */
    public func addViewedProduct(sku: String) throws {
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
    
}
