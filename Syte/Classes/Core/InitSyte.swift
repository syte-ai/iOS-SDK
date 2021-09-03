//
//  InitSyte.swift
//  Syte
//
//  Created by Artur Tarasenko on 18.08.2021.
//  Copyright © 2021 Syte.ai. All rights reserved.
//

import Foundation
import PromiseKit

public final class InitSyte {
    
    private let tag = String(describing: InitSyte.self)
    
    private enum SyteState {
        case idle, initialized
    }
    
    private var configuration: SyteConfiguration?
    private let syteService = SyteService()
    private var sytePlatformSettings: SytePlatformSettings?
    private var state = SyteState.idle
    
    public init() {}
    
    public func startSession(configuration: SyteConfiguration, completion: @escaping (SyteResult<Bool>) -> Void) {
        renewTimestamp()
        do {
            try InputValidator.validateInput(configuration: configuration)
            self.configuration = configuration
            
            firstly {
                syteService.initialize(accoundId: configuration.getAccountId())
            }.then { [weak self] response -> Promise<Void> in
                if response.isSuccessful {
                    self?.sytePlatformSettings = response.data
                    return Promise { seal in
                        seal.fulfill(())
                    }
                } else {
                    throw SyteError.initializationFailed(message: "")
                }
            }.done { [weak self] _ in
                self?.state = .initialized
                completion(.successResult)
                
                // TODO: fireEvent && getTextSearchClient
                //                        fireEvent(new EventInitialization());
                //                                        getTextSearchClient().getPopularSearchAsync(mConfiguration.getLocale(), result -> {
                //                                            if (result.isSuccessful && result.data != null && mConfiguration != null) {
                //                                                mConfiguration.getStorage().addPopularSearch(result.data, mConfiguration.getLocale());
                //                                            }
                //                                        });
                
            }.catch { [weak self] error in
                self?.state = .idle
                completion(.failureResult(message: error.localizedDescription))
            }
        } catch let error {
            state = .idle
            SyteLogger.e(tag: tag, message: error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    public func getBounds(requestData: UrlImageSearch, completion: @escaping (SyteResult<BoundsResult>) -> Void) {
        renewTimestamp()
        do {
            try verifyInitialized()
            try InputValidator.validateInput(requestData: requestData)
            
            guard let configuration = configuration else { completion(.failureResult(message: "")); return }
            let catalog = sytePlatformSettings?.data?.products?.syteapp?.features?.boundingBox?.cropper?.catalog
            firstly {
                getBounds(requestData: requestData, configuration: configuration, service: syteService, catalog: catalog)
                
            }.done { response in
                completion(response)
            }.catch { error in
                completion(.failureResult(message: error.localizedDescription))
            }
        } catch let error {
            SyteLogger.e(tag: tag, message: error.localizedDescription)
            print(error.localizedDescription)
            completion(.failureResult(message: error.localizedDescription))
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
            SyteLogger.i(tag: tag, message: "Encoded coordinates: " + (coordinatesBase64 ?? "-"))
            var url = URLComponents(string: firstBound)
            url?.queryItems = []
            let params = URLComponents(string: firstBound)
            
            print()
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
                                     crop: coordinatesBase64 ?? "",
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
