//
//  HttpClient.swift
//  Syte
//
//  Created by David Jinely on 5/31/19.
//  Copyright © 2019 David Jinely. All rights reserved.
//

import Foundation

class HttpClient: NSObject {
    private let AUTHORIZATION_HEADER = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmaW5nZXIiOiI4R0hNVzNLZGM3QWQ3K3BFSDZ1MTJnPT0iLCJ0aW1lc3RhbXAiOjE1NTQ2NDA0MjY4MjAsInV1aWQiOiI2MmFkM2I3MC0yZmY0LTVhYTktODU1NS04N2VkNTVjMzVmOWYifQ.CBi1Ehm2KUlb_e6u2R4W120SnfKqvyxJtfPiMWwEXg4"
    private let BASE_URL = "https://cdn.syteapi.com"
    private let BASE_ANALYTICS_URL = "https://syteapi.com"
    
    static let shared = HttpClient()
    private override init() {
        super.init()
    }
    
    func getCategories(success: @escaping ([String]) -> Void,
                       fail: ((SyteError?) -> Void)?) {
        let api = "http://wearesyte.com/apiexample/force_cats.json"
        guard let url = URL(string: api) else {
            fail?(InvalidApiError(url: api))
            return
        }
        
        let request = URLRequest(url: url)
        executeRequest(
            request: request,
            success: { (rawData) in
                guard let categories = rawData["force_cats"] as? [String] else {
                    fail?(NoValidDataError(rawData: rawData))
                    return
                }
                success(categories)
        }, fail: fail)
    }
    
    func getAccount(accountID: String,
                    token: String,
                    success: @escaping(Config) -> Void,
                    fail: ((SyteError) -> Void)?) {
        let api = "\(BASE_URL)/accounts/\(accountID)"
        guard let url = URL(string: api) else {
            fail?(InvalidApiError(url: api))
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Authorization": AUTHORIZATION_HEADER
        ]
        
        executeRequest(request: request, success: { (rawData) in
            let config = Config(accountID: accountID, token: token, rawData: rawData)
            success(config)
        }, fail: fail)
    }
    
    func uploadImage(fromUrl imageUrl: String,
                     params: String,
                     accountID: String,
                     token: String,
                     feeds: [String],
                     success: @escaping ([ImageBounds]) -> Void,
                     fail: ((SyteError) -> Void)?) {
        let feed = feeds.joined(separator: ",")
        let api = "\(BASE_URL)/v1.1/offers/bb?account_id=\(accountID)&sig=\(token)\(params)"
        guard let url = URL(string: api) else {
            fail?(InvalidApiError(url: api))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let imageUrlData = "[\"\(imageUrl)\"]"
        request.httpBody = Data(imageUrlData.utf8)
        executeRequest(request: request, success: { rawData in
            guard let boundsData = rawData[imageUrl] as? [AnyObject] else {
                fail?(NoValidDataError(rawData: rawData))
                return
            }
            
            let bounds = boundsData.map({ return ImageBounds(rawData: $0) })
            success(bounds)
            
        }, fail: fail)
    }
    
    func uploadImage(image: UIImage,
                     params: String,
                     accountID: String,
                     token: String,
                     feeds: [String],
                     success: @escaping ([ImageBounds]) -> Void,
                     fail: ((SyteError) -> Void)?) {
        let feed = feeds.joined(separator: ",")
        let api = "\(BASE_URL)/v1.1/offers/bb?account_id=\(accountID)&sig=\(token)&payload_type=image_bin\(params)"
        guard let url = URL(string: api) else {
            fail?(InvalidApiError(url: api))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = NSMutableData()
        body.append(imageData)
        request.httpBody = body as Data

        executeRequest(request: request, success: { rawData in
            guard let object = rawData as? NSDictionary,
                let boundsData = object.allValues.first as? [AnyObject] else { fail?(NoValidDataError(rawData: rawData))
                    return
            }
            let bounds = boundsData.map({ return ImageBounds(rawData: $0) })
            success(bounds)
            
        }, fail: fail)
    }
    
    func getOffers(api: String,
                   success: @escaping ((OfferDetails) -> Void),
                   fail: ((SyteError) -> Void)?) {
        guard let url = URL(string: api) else {
            fail?(InvalidApiError(url: api))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        executeRequest(request: request, successData: { (data) in
            do {
                let results = try JSONDecoder().decode(OfferDetails.self, from: data)
                success(results)
            } catch let err {
                fail?(NoValidDataError(rawData: err.localizedDescription as AnyObject))
            }
        }, fail: fail)
    }
}

extension HttpClient {
    private func executeRequest(request: URLRequest,
                                success: ((AnyObject) -> Void)? = nil,
                                successData: ((Data) -> Void)? = nil,
                                fail: ((SyteError) -> Void)?) {
        if Reachability.isConnectedToNetwork() == false {
            fail?(NoInternetError())
            return
        }
        
        Logger.start(url: request.url?.absoluteString ?? "")
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if let error = error {
                Logger.fail(error: error)
                fail?(SyteError(response: response, error: error))
                return
            }
            
            guard let data = data else {
                Logger.fail(error: error)
                fail?(NoDataError(rawData: response))
                return
            }
            
            if let successData = successData {
                successData(data)
                Logger.succeed(response: response)
                return
            }
            
            guard let rawData = try? JSONSerialization
                .jsonObject(with: data, options: .allowFragments) as AnyObject else {
                    fail?(NoDataError(rawData: response))
                    return
            }
            Logger.succeed(response: rawData)
            success?(rawData)
            }.resume()
    }
    
    func callAnalytics(name: String, config: Config) {
        let api = "\(BASE_ANALYTICS_URL)/et?account_id=\(config.accountID ?? "")&sig=\(config.token ?? "")&name=\(name)&count=1&tags=ios_sdk"
        guard let url = URL(string: api) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
        }.resume()
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
