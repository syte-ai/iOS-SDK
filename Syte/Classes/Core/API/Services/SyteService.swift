//
//  SyteService.swift
//  Syte
//
//  Created by Artur Tarasenko on 21.08.2021.
//

import Moya
import PromiseKit

protocol SyteServiceProtocol: class {
    
    func initialize(accoundId: String) -> Promise<SyteResult<SytePlatformSettings>>
    
    func getBounds(parameters: GetBoundsParameters) -> Promise<SyteResult<BoundsResult>>
    
    func getOffers(parameters: GetOffersParameters) -> Promise<SyteResult<ItemsResult>>
    
    func getSimilars(parameters: GetSimilarsParameters) -> Promise<SyteResult<SimilarProductsResult>>
    
    func getShopTheLook(parameters: GetShopTheLookParameters) -> Promise<SyteResult<ShopTheLookResult>>
    
    func getAutoComplete(parameters: GetAutoCompleteParameters) -> Promise<SyteResult<AutoCompleteResult>>
    
}

class SyteService: SyteServiceProtocol {
    
#if DEBUG
    private let service = MoyaProvider<SyteProvider>(plugins: [NetworkLoggerPlugin(verbose: true)])
#else
    private let service = MoyaProvider<SyteProvider>
#endif
    
    func initialize(accoundId: String) -> Promise<SyteResult<SytePlatformSettings>> {
        return sendRequestWithDefaultHandling(request: .initialize(accountId: accoundId))
    }
    
    func getBounds(parameters: GetBoundsParameters) -> Promise<SyteResult<BoundsResult>> {
        service.request(.getBounds(parameters: parameters)).map { response -> SyteResult<BoundsResult> in
            let result = SyteResult<BoundsResult>()
            result.resultCode = response.statusCode
            do {
                _ = try response.filterSuccessfulStatusCodes()
                let mapString = try response.mapString().replacingOccurrences(of: parameters.imageUrl, with: "bounds")
                let formattedResponse = Response(statusCode: response.statusCode, data: mapString.data(using: .utf8) ?? Data())
                let bounds = try formattedResponse.map(BoundsResult.self)
                result.data = bounds
                result.isSuccessful = true
            } catch {
                let stringResponse = try? response.mapString()
                result.errorMessage = stringResponse ?? error.localizedDescription
            }
            return result
        }
    }
    
    func getOffers(parameters: GetOffersParameters) -> Promise<SyteResult<ItemsResult>> {
        return sendRequestWithDefaultHandling(request: .getOffers(parameters: parameters))
    }
    
    func getSimilars(parameters: GetSimilarsParameters) -> Promise<SyteResult<SimilarProductsResult>> {
        return sendRequestWithDefaultHandling(request: .getSimilars(parameters: parameters))
    }
    
    func getShopTheLook(parameters: GetShopTheLookParameters) -> Promise<SyteResult<ShopTheLookResult>> {
        return sendRequestWithDefaultHandling(request: .getShopTheLook(parameters: parameters))
    }
    
    func getPersonalization(parameters: GetPersonalizationParameters) -> Promise<SyteResult<PersonalizationResult>> {
        return sendRequestWithDefaultHandling(request: .getPersonalization(parameters: parameters))
    }
    
    func getAutoComplete(parameters: GetAutoCompleteParameters) -> Promise<SyteResult<AutoCompleteResult>> {
        return sendRequestWithDefaultHandling(request: .getAutoComplete(parameters: parameters))
    }
    
    func getPopularSearch(parameters: GetPopularSearchParameters) -> Promise<SyteResult<[String]>> {
        return sendRequestWithDefaultHandling(request: .getPopularSearch(parameters: parameters))
    }
    
    func getTextSearch(parameters: GetTextSearchParameters) -> Promise<SyteResult<TextSearchResult>> {
        return sendRequestWithDefaultHandling(request: .getTextSearch(parameters: parameters))
    }
    
    private func sendRequestWithDefaultHandling<T: Codable>(request: SyteProvider) -> Promise<SyteResult<T>> {
        service.request(request).map { response -> SyteResult<T> in
            return Self.mapDefaultResponse(response: response)
        }
    }
    
    private static func mapDefaultResponse<T: Codable>(response: Response) -> SyteResult<T> {
        let result = SyteResult<T>()
        result.resultCode = response.statusCode
        do {
            _ = try response.filterSuccessfulStatusCodes()
            let item = try response.map(T.self)
            result.data = item
            result.isSuccessful = true
        } catch {
            let stringResponse = try? response.mapString()
            result.errorMessage = stringResponse ?? error.localizedDescription
        }
        return result
    }
    
}
