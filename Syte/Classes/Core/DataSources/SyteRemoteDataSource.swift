//
//  SyteRemoteDataSource.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation
import PromiseKit

class SyteRemoteDataSource: BaseRemoteDataSource {
    
    private static let tag = String(describing: SyteRemoteDataSource.self)
    
    private let syteService = SyteService()
    private let exifService = ExifService()
    private let recommendationRemoteDataSource: RecommendationRemoteDataSource
    private let textSearchRemoteDataSource: TextSearchRemoteDataSource
    
    override init(configuration: SyteConfiguration) {
        recommendationRemoteDataSource = RecommendationRemoteDataSource(configuration: configuration, syteService: syteService)
        textSearchRemoteDataSource = TextSearchRemoteDataSource(configuration: configuration, syteService: syteService)
        super.init(configuration: configuration)
    }
    
    func getSettings(completion: @escaping (SyteResult<SytePlatformSettings>) -> Void) {
        renewTimestamp()
        firstly {
            syteService.getSettings(accoundId: configuration.accountId)
        }.done { result in
            completion(result)
        }.catch { error in
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    func getOffers(offersUrl: String,
                   crop: CropCoordinates?,
                   completion: @escaping (SyteResult<ItemsResult>) -> Void) {
        renewTimestamp()
        firstly {
            generateOffersCall(offersUrl: offersUrl, cropCoordinates: crop)
        }.done { response in
            completion(response)
        }.catch { error in
            completion(.failureResult(message: error.localizedDescription))
        }
        
    }
    
    func getBounds(requestData: UrlImageSearch,
                   completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        renewTimestamp()
        firstly {
            getBounds(requestData: requestData)
        }.done { response in
            completion(response)
        }.catch { error in
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    func getBoundsWild(requestData: ImageSearch,
                       completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        renewTimestamp()
        firstly {
            prepareImageSearchRequestData(requestData: requestData)
        }.then { [weak self] response -> Promise<SyteResult<BoundsResult>>  in
            guard let strongSelf = self else { throw SyteError.generalError(message: "Something went wrong.") }
            guard let responseData = response.data else { throw SyteError.generalError(message: "Exif removal service returned empty body.") }
            responseData.retrieveOffersForTheFirstBound = requestData.retrieveOffersForTheFirstBound
            responseData.coordinates = requestData.coordinates
            responseData.personalizedRanking = requestData.personalizedRanking
            return strongSelf.getBounds(requestData: responseData)
        }.done { response in
            completion(response)
        }.catch { error in
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    func getSimilarProducts(similarProducts: SimilarProducts, completion: @escaping (SyteResult<SimilarProductsResult>) -> Void) {
        renewTimestamp()
        recommendationRemoteDataSource.getSimilarProducts(similarProducts: similarProducts, completion: completion)
    }
    
    func getShopTheLook(shopTheLook: ShopTheLook, completion: @escaping (SyteResult<ShopTheLookResult>) -> Void) {
        renewTimestamp()
        recommendationRemoteDataSource.getShopTheLook(shopTheLook: shopTheLook, completion: completion)
    }
    
    func getPersonalization(personalization: Personalization,
                            completion: @escaping (SyteResult<PersonalizationResult>) -> Void) {
        renewTimestamp()
        recommendationRemoteDataSource.getPersonalization(personalization: personalization, completion: completion)
    }
    
    func getAutoComplete(query: String,
                         lang: String,
                         completion: @escaping (SyteResult<AutoCompleteResult>) -> Void) {
        renewTimestamp()
        textSearchRemoteDataSource.getAutoComplete(query: query, lang: lang, completion: completion)
    }
    
    func getPopularSearch(lang: String, completion: @escaping (SyteResult<[String]>) -> Void) {
        renewTimestamp()
        textSearchRemoteDataSource.getPopularSearch(lang: lang, completion: completion)
    }
    
    func getTextSearch(textSearch: TextSearch, completion: @escaping (SyteResult<TextSearchResult>) -> Void) {
        renewTimestamp()
        textSearchRemoteDataSource.getTextSearch(textSearch: textSearch, completion: completion)
    }
    
    private func prepareImageSearchRequestData(requestData: ImageSearch) -> Promise<SyteResult<UrlImageSearch>> {
        var size = 0
        let imageSize = requestData.image.getImageSizeInKbAsJpeg()
        size = imageSize > 0 ? imageSize : 0
        return firstly {
            ImageProcessor.compressToDataWithLoseQuality(image: requestData.image,
                                                         size: size,
                                                         scale: requestData.scale)
        }.then { [weak self] imageData -> Promise<SyteResult<UrlImageSearch>>  in
            guard let strongSelf = self,
                  let finalImageData = imageData else { return .init(error: SyteError.generalError(message: "Image is too big.")) }
            SyteLogger.i(tag: SyteRemoteDataSource.tag, message: "Compressed image size: \(finalImageData.getSizeInKB()), data: \(finalImageData)")
            
            return strongSelf.exifService.removeTags(accountId: strongSelf.configuration.accountId,
                                                     signature: strongSelf.configuration.signature,
                                                     imagePayload: finalImageData).map { response -> SyteResult<UrlImageSearch> in
                return response
            }
        }
    }
    
    private func getBounds(requestData: UrlImageSearch) -> Promise<SyteResult<BoundsResult>> {
        return firstly {
            syteService.getBounds(parameters: .init(accountId: configuration.accountId,
                                                    signature: configuration.signature,
                                                    userId: requestData.personalizedRanking ? configuration.userId : nil,
                                                    sessionId: requestData.personalizedRanking ? String(configuration.sessionId) : nil,
                                                    syteAppRef: requestData.productType.getName(),
                                                    locale: configuration.locale,
                                                    sku: requestData.sku,
                                                    imageUrl: requestData.imageUrl,
                                                    sessionSkus: requestData.personalizedRanking ?
                                                        Utils.viewedProductsString(viewedProducts: configuration.getViewedProducts()) : nil,
                                                    options: requestData.options))
        }.then { [weak self] response -> Promise<SyteResult<BoundsResult>>  in
            guard let strongSelf = self else { return .value(response) }
            return strongSelf.handleBoundsResult(response, requestData: requestData)
        }
    }
    
    private func handleBoundsResult(_ response: SyteResult<BoundsResult>,
                                    requestData: UrlImageSearch) -> Promise<SyteResult<BoundsResult>> {
        guard let data = response.data,
              let bound = data.bounds,
              let firstBound = bound.first?.offersUrl,
              requestData.retrieveOffersForTheFirstBound else { return .value(response) }
        
        return generateOffersCall(offersUrl: firstBound,
                                  cropCoordinates: requestData.coordinates).map { offers -> SyteResult<BoundsResult> in
                                    response.data?.firstBoundItemsResult = offers.data
                                    return response
                                  }
    }
    
    private func generateOffersCall(offersUrl: String,
                                    cropCoordinates: CropCoordinates?) -> Promise<SyteResult<ItemsResult>> {
        let cropEnabled = cropCoordinates != nil
        var actualUrl: String?
        var coordinatesBase64: String?
        
        if let crop = cropCoordinates {
            coordinatesBase64 = crop.toString().data(using: .utf8)?.base64EncodedString()
            SyteLogger.i(tag: SyteRemoteDataSource.tag, message: "Encoded coordinates: " + (coordinatesBase64 ?? "-"))
            var url = URLComponents(string: offersUrl)
            url?.queryItems = []
            let params = URLComponents(string: offersUrl)
            
            for param in params?.queryItems ?? [] {
                if param.name == "cats" || param.name == "crop" || param.name == "catalog" || param.name == "feed" { continue }
                url?.queryItems?.append(param)
            }
            actualUrl = url?.string
        } else {
            actualUrl = offersUrl
        }
        
        return syteService.getOffers(parameters: .init(offersUrl: actualUrl ?? "",
                                                       crop: coordinatesBase64,
                                                       forceCats: cropEnabled ? Catalog.general.getName() : nil))
        
    }
    
}
