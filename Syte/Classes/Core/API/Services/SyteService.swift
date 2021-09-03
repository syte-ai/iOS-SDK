//
//  SyteService.swift
//  Syte
//
//  Created by Artur Tarasenko on 21.08.2021.
//

import Moya
import PromiseKit

// swiftlint:disable function_parameter_count

protocol SyteServiceProtocol: class {
    
    func initialize(accoundId: String) -> Promise<SyteResult<SytePlatformSettings>>
    
    func getBounds(accountId: String, signature: String, userId: String?, sessionId: String?,
                   syteAppRef: String, locale: String, catalog: String?, sku: String?,
                   imageUrl: String, sessionSkus: String?, options: [String: String]) -> Promise<SyteResult<BoundsResult>>
    
    func getOffers(offersUrl: String, crop: String, forceCats: String?, catalog: String?) -> Promise<SyteResult<ItemsResult>>
    
}

public class SyteService: SyteServiceProtocol {
    
    private let service = MoyaProvider<SyteProvider>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func initialize(accoundId: String) -> Promise<SyteResult<SytePlatformSettings>> {
        service.request(.initialize(accountId: accoundId)).map { response -> SyteResult<SytePlatformSettings> in
            let result = SyteResult<SytePlatformSettings>()
            result.resultCode = response.statusCode
            do {
                let settings = try response.map(SytePlatformSettings.self)
                // TODO: Test data, remove later
                let stringResponse = (try? response.mapString()) ?? ""
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "test_response"),
                                                object: nil,
                                                userInfo: ["request": "initialize", "data": stringResponse])
                //
                result.data = settings
                result.isSuccessful = true
            } catch {
                result.errorMessage = error.localizedDescription
            }
            return result
        }
    }
    
    func getBounds(accountId: String, signature: String, userId: String?, sessionId: String?,
                   syteAppRef: String, locale: String, catalog: String?, sku: String?,
                   imageUrl: String, sessionSkus: String?, options: [String: String]) -> Promise<SyteResult<BoundsResult>> {
        service.request(.getBounds(accountId: accountId, signature: signature, userId: userId, sessionId: sessionId, syteAppRef: syteAppRef, locale: locale, catalog: catalog, sku: sku, imageUrl: imageUrl, sessionSkus: sessionSkus, options: options)).map { response -> SyteResult<BoundsResult> in
            let result = SyteResult<BoundsResult>()
            result.resultCode = response.statusCode
            do {
                let mapString = try response.mapString().replacingOccurrences(of: imageUrl, with: "bounds")
                // TODO: Test data, remove later
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "test_response"),
                                                object: nil,
                                                userInfo: ["request": "getBounds", "data": mapString])
                //
                let formattedResponse = Response(statusCode: response.statusCode, data: mapString.data(using: .utf8) ?? Data())
                let bounds = try formattedResponse.map(BoundsResult.self)
                result.data = bounds
                result.isSuccessful = true
            } catch {
                result.errorMessage = error.localizedDescription
            }
            return result
        }
    }
    
    func getOffers(offersUrl: String, crop: String, forceCats: String?, catalog: String?) -> Promise<SyteResult<ItemsResult>> {
        service.request(.getOffers(offersUrl: offersUrl, crop: crop, forceCats: forceCats, catalog: catalog)).map { response -> SyteResult<ItemsResult> in
            let result = SyteResult<ItemsResult>()
            result.resultCode = response.statusCode
            do {
                // TODO: Test data, remove later
                let stringResponse = (try? response.mapString()) ?? ""
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "test_response"),
                                                object: nil,
                                                userInfo: ["request": "getOffers", "data": stringResponse])
                //
                let item = try response.map(ItemsResult.self)
                result.data = item
                result.isSuccessful = true
            } catch {
                result.errorMessage = error.localizedDescription
            }
            return result
        }
    }
    
}
// swiftlint:enable function_parameter_count
