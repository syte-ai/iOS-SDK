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
    
    private static let tag = String(describing: Syte.self)
    
    private enum SyteState {
        case idle, initialized
    }
    
    private var configuration: SyteConfiguration?
    private let syteService = SyteService()
    private let exifService = ExifService()
    private var sytePlatformSettings: SytePlatformSettings?
    private var state = SyteState.idle
    
    private init() {}
    
    public static func initialize(configuration: SyteConfiguration, completion: @escaping (SyteResult<Syte>) -> Void) {
        do {
            try InputValidator.validateInput(configuration: configuration)
            
            let syte = Syte()
            syte.configuration = configuration
            
            firstly {
                syte.syteService.initialize(accoundId: configuration.getAccountId())
            }.then { response -> Promise<SyteResult<SytePlatformSettings>> in
                if response.isSuccessful {
                    syte.sytePlatformSettings = response.data
                    return .value(response)
                } else {
                    throw SyteError.initializationFailed(message: "")
                }
            }.done { result in
                syte.state = .initialized
                //                if (mState == SyteState.INITIALIZED) {
                //                                fireEvent(new EventInitialization());
                //                            }
                completion(.successResult(data: syte, code: result.resultCode))
                
            }.catch { error in
                syte.state = .idle
                completion(.failureResult(message: error.localizedDescription))
            }
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getBounds(requestData: UrlImageSearch, completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        renewTimestamp()
        do {
            try verifyInitialized()
            try InputValidator.validateInput(requestData: requestData)
            
            guard let configuration = configuration else { completion(.failureResult(message: "Missing configuration")); return }
            let catalog = sytePlatformSettings?.data?.products?.syteapp?.features?.boundingBox?.cropper?.catalog
            firstly {
                getBounds(requestData: requestData, configuration: configuration, service: syteService, catalog: catalog)
                
            }.done { response in
                completion(response)
            }.catch { error in
                completion(.failureResult(message: error.localizedDescription))
            }
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            print(error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
        
    }
    
    public func getBoundsWild(requestData: ImageSearch, completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        renewTimestamp()
        do {
            try verifyInitialized()
            
            guard let configuration = configuration else { completion(.failureResult(message: "Missing configuration")); return }
            let catalog = sytePlatformSettings?.data?.products?.syteapp?.features?.boundingBox?.cropper?.catalog
            firstly {
                prepareImageSearchRequestData(requestData: requestData, configuration: configuration)
            }.then { [weak self] response -> Promise<SyteResult<BoundsResult>>  in
                guard let strongSelf = self else { throw SyteError.generalError(message: "Something went wrong.") }
                guard let responseData = response.data else { throw SyteError.generalError(message: "Exif removal service returned empty body.") }
                responseData.retrieveOffersForTheFirstBound = requestData.retrieveOffersForTheFirstBound
                responseData.coordinates = requestData.coordinates
                responseData.personalizedRanking = requestData.personalizedRanking
                return strongSelf.getBounds(requestData: responseData, configuration: configuration, service: strongSelf.syteService, catalog: catalog)
            }.done { response in
                completion(response)
            }.catch { error in
                completion(.failureResult(message: error.localizedDescription))
            }
        } catch let error {
            SyteLogger.e(tag: Syte.tag, message: error.localizedDescription)
            print(error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
        
    }
    
    private func prepareImageSearchRequestData(requestData: ImageSearch, configuration: SyteConfiguration) -> Promise<SyteResult<UrlImageSearch>> {
        var size = 0
        let imageSize = requestData.image.getImageSizeInKbAsJpeg()
        size = imageSize > 0 ? imageSize : 0
        return firstly {
            ImageProcessor.compressToDataWithLoseQuality(image: requestData.image, size: size, scale: Utils.getImageScale(settings: sytePlatformSettings))
        }.then { [weak self] imageData -> Promise<SyteResult<UrlImageSearch>>  in
            guard let strongSelf = self,
                  let finalImageData = imageData else { return .init(error: SyteError.generalError(message: "Image is too big.")) }
            SyteLogger.i(tag: Syte.tag, message: "Compressed image size: \(finalImageData.getSizeInKB()), data: \(finalImageData)")
            
            return strongSelf.exifService.removeTags(accountId: configuration.getAccountId(),
                                                     signature: configuration.getApiSignature(),
                                                     imagePayload: finalImageData).map { response -> SyteResult<UrlImageSearch> in
                                                        return response
                                                     }
        }
    }
    
    private func getBounds(requestData: UrlImageSearch, configuration: SyteConfiguration, service: SyteService, catalog: String?) -> Promise<SyteResult<BoundsResult>> {
        return firstly {
            syteService.getBounds(accountId: configuration.getAccountId(),
                                  signature: configuration.getApiSignature(),
                                  userId: requestData.personalizedRanking ? configuration.getUserId() : nil,
                                  sessionId: requestData.personalizedRanking ? String(configuration.getSessionId()) : nil,
                                  syteAppRef: requestData.productType.getName(),
                                  locale: configuration.getLocale(),
                                  catalog: catalog,
                                  sku: requestData.sku,
                                  imageUrl: requestData.imageUrl,
                                  sessionSkus: requestData.personalizedRanking ? Utils.viewedProductsString(viewedProducts: configuration.getViewedProducts()) : nil,
                                  options: requestData.options)
        }.then { [weak self] response -> Promise<SyteResult<BoundsResult>>  in
            guard let strongSelf = self else { return .value(response) }
            return strongSelf.handleBoundsResult(response, requestData: requestData)
        }
        
    }
    
    private func handleBoundsResult(_ response: SyteResult<BoundsResult>, requestData: UrlImageSearch) -> Promise<SyteResult<BoundsResult>> {
        guard let data = response.data,
              let bound = data.bounds,
              let firstBound = bound.first?.offersUrl,
              requestData.retrieveOffersForTheFirstBound else { return .value(response) }
        
        let cropEnabled = requestData.coordinates != nil
        var actualUrl: String?
        var coordinatesBase64: String?
        
        if let crop = requestData.coordinates {
            coordinatesBase64 = crop.toString().data(using: .utf8)?.base64EncodedString()
            SyteLogger.i(tag: Syte.tag, message: "Encoded coordinates: " + (coordinatesBase64 ?? "-"))
            var url = URLComponents(string: firstBound)
            url?.queryItems = []
            let params = URLComponents(string: firstBound)
            
            for param in params?.queryItems ?? [] {
                if param.name == "cats" || param.name == "crop" || param.name == "catalog" || param.name == "feed" { continue }
                url?.queryItems?.append(param)
            }
            actualUrl = url?.string
        } else {
            actualUrl = firstBound
        }
        let settingsCatalog = sytePlatformSettings?.data?.products?.syteapp?.features?.boundingBox?.cropper?.catalog
        
        return syteService.getOffers(offersUrl: actualUrl ?? "",
                                     crop: coordinatesBase64,
                                     forceCats: cropEnabled ? Catalog.general.getName() : nil,
                                     catalog: cropEnabled ? settingsCatalog : nil).map { offers -> SyteResult<BoundsResult> in
                                        response.data?.firstBoundItemsResult = offers.data
                                        return response
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
    
    private func verifyInitialized() throws {
        guard state == .initialized else { throw SyteError.initializationFailed(message: "Syte is not initialized.")}
    }
    
    private func renewTimestamp() {
        configuration?.getStorage().renewSessionIdTimestamp()
    }
    
}
