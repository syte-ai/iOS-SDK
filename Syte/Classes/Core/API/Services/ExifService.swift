//
//  ExifService.swift
//  Syte
//
//  Created by Artur Tarasenko on 07.09.2021.
//

import Moya
import PromiseKit

protocol ExifServiceProtocol: class {
    func removeTags(accountId: String, signature: String, imagePayload: Data) -> Promise<SyteResult<UrlImageSearch>>
    
}

class ExifService: ExifServiceProtocol {
    
    // TODO: remmove "(plugins: [NetworkLoggerPlugin(verbose: true)])" on release
    private let service = MoyaProvider<ExifProvider>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func removeTags(accountId: String, signature: String, imagePayload: Data) -> Promise<SyteResult<UrlImageSearch>> {
        service.request(.removeTags(accountId: accountId, signature: signature, imagePayload: imagePayload)).map { response -> SyteResult<UrlImageSearch> in
            let result = SyteResult<UrlImageSearch>()
            result.resultCode = response.statusCode
            do {
                let responseJson = try response.mapJSON() as? [String: Any]
                let url = responseJson?["url"] as? String ?? ""
                let requestData = UrlImageSearch(imageUrl: url, productType: .discoveryButton)
                result.data = requestData
                result.isSuccessful = true
            } catch {
                result.errorMessage = error.localizedDescription
            }
            return result
        }
    }
    
}
