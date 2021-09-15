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
    
    override init(configuration: SyteConfiguration) {
        super.init(configuration: configuration)
    }
    
    func initialize(completion: @escaping (SyteResult<SytePlatformSettings>) -> Void) {
        renewTimestamp()
        firstly {
            syteService.initialize(accoundId: configuration.accountId)
        }.done { result in
            completion(result)
        }.catch { error in
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    func getOffers(offersUrl: String,
                   crop: CropCoordinates?,
                   sytePlatformSettings: SytePlatformSettings,
                   completion: @escaping (SyteResult<ItemsResult>) -> Void) {
        renewTimestamp()
        firstly {
            generateOffersCall(offersUrl: offersUrl, cropCoordinates: crop, sytePlatformSettings: sytePlatformSettings)
        }.done { response in
            completion(response)
        }.catch { error in
            completion(.failureResult(message: error.localizedDescription))
        }
        
    }
    
    func getBounds(requestData: UrlImageSearch,
                   sytePlatformSettings: SytePlatformSettings,
                   completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        renewTimestamp()
        let catalog = sytePlatformSettings.data?.products?.syteapp?.features?.boundingBox?.cropper?.catalog
        firstly {
            getBounds(requestData: requestData, sytePlatformSettings: sytePlatformSettings, catalog: catalog)
        }.done { response in
            completion(response)
        }.catch { error in
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    func getBoundsWild(requestData: ImageSearch,
                       sytePlatformSettings: SytePlatformSettings,
                       completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        renewTimestamp()
        
        let catalog = sytePlatformSettings.data?.products?.syteapp?.features?.boundingBox?.cropper?.catalog
        firstly {
            prepareImageSearchRequestData(requestData: requestData, sytePlatformSettings: sytePlatformSettings)
        }.then { [weak self] response -> Promise<SyteResult<BoundsResult>>  in
            guard let strongSelf = self else { throw SyteError.generalError(message: "Something went wrong.") }
            guard let responseData = response.data else { throw SyteError.generalError(message: "Exif removal service returned empty body.") }
            responseData.retrieveOffersForTheFirstBound = requestData.retrieveOffersForTheFirstBound
            responseData.coordinates = requestData.coordinates
            responseData.personalizedRanking = requestData.personalizedRanking
            return strongSelf.getBounds(requestData: responseData, sytePlatformSettings: sytePlatformSettings, catalog: catalog)
        }.done { response in
            completion(response)
        }.catch { error in
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    private func prepareImageSearchRequestData(requestData: ImageSearch, sytePlatformSettings: SytePlatformSettings) -> Promise<SyteResult<UrlImageSearch>> {
        var size = 0
        let imageSize = requestData.image.getImageSizeInKbAsJpeg()
        size = imageSize > 0 ? imageSize : 0
        return firstly {
            ImageProcessor.compressToDataWithLoseQuality(image: requestData.image,
                                                         size: size,
                                                         scale: Utils.getImageScale(settings: sytePlatformSettings))
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
    
    private func getBounds(requestData: UrlImageSearch, sytePlatformSettings: SytePlatformSettings, catalog: String?) -> Promise<SyteResult<BoundsResult>> {
        return firstly {
            syteService.getBounds(accountId: configuration.accountId,
                                  signature: configuration.signature,
                                  userId: requestData.personalizedRanking ? configuration.userId : nil,
                                  sessionId: requestData.personalizedRanking ? String(configuration.sessionId) : nil,
                                  syteAppRef: requestData.productType.getName(),
                                  locale: configuration.locale,
                                  catalog: catalog,
                                  sku: requestData.sku,
                                  imageUrl: requestData.imageUrl,
                                  sessionSkus: requestData.personalizedRanking ? Utils.viewedProductsString(viewedProducts: configuration.getViewedProducts()) : nil,
                                  options: requestData.options)
        }.then { [weak self] response -> Promise<SyteResult<BoundsResult>>  in
            guard let strongSelf = self else { return .value(response) }
            return strongSelf.handleBoundsResult(response, requestData: requestData, sytePlatformSettings: sytePlatformSettings)
        }
    }
    
    private func handleBoundsResult(_ response: SyteResult<BoundsResult>,
                                    requestData: UrlImageSearch,
                                    sytePlatformSettings: SytePlatformSettings) -> Promise<SyteResult<BoundsResult>> {
        guard let data = response.data,
              let bound = data.bounds,
              let firstBound = bound.first?.offersUrl,
              requestData.retrieveOffersForTheFirstBound else { return .value(response) }
        
        return generateOffersCall(offersUrl: firstBound,
                                  cropCoordinates: requestData.coordinates,
                                  sytePlatformSettings: sytePlatformSettings).map { offers -> SyteResult<BoundsResult> in
                                    response.data?.firstBoundItemsResult = offers.data
                                    return response
                                  }
    }
    
    private func generateOffersCall(offersUrl: String,
                                    cropCoordinates: CropCoordinates?,
                                    sytePlatformSettings: SytePlatformSettings) -> Promise<SyteResult<ItemsResult>> {
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
        let settingsCatalog = sytePlatformSettings.data?.products?.syteapp?.features?.boundingBox?.cropper?.catalog
        
        return syteService.getOffers(offersUrl: actualUrl ?? "",
                                     crop: coordinatesBase64,
                                     forceCats: cropEnabled ? Catalog.general.getName() : nil,
                                     catalog: cropEnabled ? settingsCatalog : nil)
        
    }
    
}
