//
//  SyteManager.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 10.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Syte

class SyteManager {
    
    static let shared = SyteManager()
    
    private var syte: Syte
    
    private init() {
        let configuration = SyteConfiguration(accountId: "9165", signature: "601c206d0a7f780efb9360f3")
        syte = Syte(configuration: configuration)!
    }
    
    public func getBoundsForImageUrl(requestData: UrlImageSearch, completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        syte.getBoundsForImageUrl(imageSearch: requestData, completion: completion)
    }
    
    public func getItemsForBound(bound: Bound,
                                 cropCoordinates: CropCoordinates?,
                                 completion: @escaping (SyteResult<ItemsResult>) -> Void) {
        syte.getItemsForBound(bound: bound, cropCoordinates: cropCoordinates, completion: completion)
    }
    
    public func getBoundsForImage(requestData: ImageSearch, completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        syte.getBoundsForImage(imageSearch: requestData, completion: completion)
    }
    
    public func getSimilarProducts(similarProducts: SimilarProducts,
                                   completion: @escaping (SyteResult<SimilarProductsResult>) -> Void) {
        syte.getSimilarProducts(similarProducts: similarProducts, completion: completion)
    }
    
    public func getShopTheLook(shopTheLook: ShopTheLook, completion: @escaping (SyteResult<ShopTheLookResult>) -> Void) {
        syte.getShopTheLook(shopTheLook: shopTheLook, completion: completion)
    }
    
    public func getPersonalization(personalization: Personalization,
                                   completion: @escaping (SyteResult<PersonalizationResult>) -> Void) {
        syte.getPersonalization(personalization: personalization, completion: completion)
    }
    
    public func getAutoCompleteForTextSearch(query: String,
                                             lang: String?,
                                             completion: @escaping (SyteResult<AutoCompleteResult>) -> Void) {
        syte.getAutoCompleteForTextSearch(query: query, lang: lang, completion: completion)
    }
    
    public func getPopularSearches(lang: String, completion: @escaping (SyteResult<[String]>) -> Void) {
        syte.getPopularSearches(lang: lang, completion: completion)
    }
    
    public func getTextSearch(query: String, lang: String?, completion: @escaping (SyteResult<TextSearchResult>) -> Void) {
        let textSearchData = TextSearch(query: query, lang: lang ?? syte.getConfiguration().locale)
        syte.getTextSearch(textSearch: textSearchData, completion: completion)
    }
    
    public func getPlatformSettings(completion: @escaping (SyteResult<SytePlatformSettings>) -> Void) {
        syte.getPlatformSettings(completion: completion)
    }
    
    public func fire(event: BaseSyteEvent) {
        syte.fire(event: event)
    }
    
    public func getSearchHistory() -> [String] {
        return syte.getRecentTextSearches()
    }
    
    public func addViewedProduct(sku: String) throws {
        try syte.addViewedProduct(sku: sku)
    }
    
    public func getViewedProducts() -> [String] {
        return Array(syte.getViewedProducts())
    }
    
    public func setLocale(_ locale: String) {
        syte.getConfiguration().locale = locale
    }
    
    public func getLocale() -> String {
        return syte.getConfiguration().locale
    }
    
}
