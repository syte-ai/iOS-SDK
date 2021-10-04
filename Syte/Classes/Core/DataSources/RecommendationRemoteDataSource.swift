//
//  RecommendationRemoteDataSource.swift
//  Syte
//
//  Created by Artur Tarasenko on 17.09.2021.
//

import Foundation
import PromiseKit

class RecommendationRemoteDataSource: BaseRemoteDataSource {
    
    enum RecommendationProduct: String {
        case similarProducts = "similars"
        case shopTheLook = "ctl"
        case personalization = "personalization"
    }
    
    private static let tag = String(describing: RecommendationRemoteDataSource.self)
    
    private let syteService: SyteService
    
    init(configuration: SyteConfiguration, syteService: SyteService) {
        self.syteService = syteService
        super.init(configuration: configuration)
    }
    
    func getSimilarProducts(similarProducts: SimilarProducts, completion: @escaping (SyteResult<SimilarProductsResult>) -> Void) {
        firstly {
            syteService.getSimilars(parameters: .init(accountId: configuration.accountId,
                                                      signature: configuration.signature,
                                                      userId: similarProducts.personalizedRanking ? configuration.userId : nil,
                                                      sessionId: similarProducts.personalizedRanking ? String(configuration.sessionId) : nil,
                                                      syteAppRef: RecommendationProduct.similarProducts.getName(),
                                                      locale: configuration.locale,
                                                      fields: similarProducts.fieldsToReturn.getName(),
                                                      sku: "sku:" + similarProducts.sku,
                                                      features: RecommendationProduct.similarProducts.getName(),
                                                      product: RecommendationProduct.similarProducts.getName(),
                                                      sessionSkus: similarProducts.personalizedRanking ?
                                                        Utils.viewedProductsString(viewedProducts: configuration.getViewedProducts()) : nil,
                                                      limit: similarProducts.limit,
                                                      syteUrlReferer: similarProducts.syteUrlReferer,
                                                      imageUrl: similarProducts.imageUrl,
                                                      options: similarProducts.options))
        }.done { result in
            completion(result)
        }.catch { error in
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    func getShopTheLook(shopTheLook: ShopTheLook,
                        completion: @escaping (SyteResult<ShopTheLookResult>) -> Void) {
        firstly {
            syteService.getShopTheLook(parameters: .init(accountId: configuration.accountId,
                                                         signature: configuration.signature,
                                                         userId: shopTheLook.personalizedRanking ? configuration.userId : nil,
                                                         sessionId: shopTheLook.personalizedRanking ? String(configuration.sessionId) : nil,
                                                         syteAppRef: RecommendationProduct.shopTheLook.getName(),
                                                         locale: configuration.locale,
                                                         fields: shopTheLook.fieldsToReturn.getName(),
                                                         sku: "sku:" + shopTheLook.sku,
                                                         features: RecommendationProduct.shopTheLook.getName(),
                                                         product: RecommendationProduct.shopTheLook.getName(),
                                                         sessionSkus: shopTheLook.personalizedRanking ?
                                                            Utils.viewedProductsString(viewedProducts: configuration.getViewedProducts()) : nil,
                                                         limit: shopTheLook.limit,
                                                         syteUrlReferer: shopTheLook.syteUrlReferer,
                                                         limitPerBound: shopTheLook.limitPerBound == -1 ? nil : String(shopTheLook.limitPerBound),
                                                         originalItem: shopTheLook.syteOriginalItem,
                                                         imageUrl: shopTheLook.imageUrl,
                                                         options: shopTheLook.options))
        }.done { result in
            let shopTheLookResult = result
            completion(shopTheLookResult)
        }.catch { error in
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    func getPersonalization(personalization: Personalization, completion: @escaping (SyteResult<PersonalizationResult>) -> Void) {
            firstly {
                generatePersonalizationCall(personalization: personalization)
            }.done { result in
                completion(result)
            }.catch { error in
                completion(.failureResult(message: error.localizedDescription))
            }
    }
    
    private func generatePersonalizationCall(personalization: Personalization) -> Promise<SyteResult<PersonalizationResult>> {
        if Utils.viewedProductsJSONArray(viewedProducts: configuration.getViewedProducts()) == nil &&
            Utils.viewedProductsJSONArray(sku: personalization.sku) == nil {
            return .init(error: SyteError.wrongInput(message: "There are no viewed products added. Can not proceed with the personalization call."))
        }
        
        var viewedProducts = Utils.viewedProductsJSONArray(viewedProducts: configuration.getViewedProducts())
        viewedProducts = viewedProducts ?? Utils.viewedProductsJSONArray(sku: personalization.sku)
        let body = "{\n    \"user_uuid\": \"\(configuration.userId)\",\n    \"session_skus\": \(viewedProducts ?? ""),\n    \"model_version\": \"\(personalization.modelVersion)\"\n}".data(using: .utf8)

        return syteService.getPersonalization(parameters: .init(accountId: configuration.accountId,
                                                                signature: configuration.signature,
                                                                syteAppRef: RecommendationProduct.personalization.getName(),
                                                                locale: configuration.locale,
                                                                fields: personalization.fieldsToReturn.getName(),
                                                                features: RecommendationProduct.personalization.getName(),
                                                                product: RecommendationProduct.personalization.getName(),
                                                                limit: personalization.limit,
                                                                syteUrlReferer: personalization.syteUrlReferer,
                                                                body: body ?? Data(),
                                                                options: personalization.options))
    }
    
}
