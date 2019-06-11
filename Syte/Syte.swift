//
//  Syte.swift
//  Syte
//
//  Created by David Jinely on 6/1/19.
//  Copyright © 2019 David Jinely. All rights reserved.
//

import Foundation

open class SyteAI: NSObject {
    var config = Config()
    var isOverrideConfig = false
    
    public func getCategory(completion: @escaping (_ categories: [String], _ error: SyteError?) -> Void) {
        HttpClient.shared.getCategories(success: { [weak self] (categories) in
            completion(categories, nil)
            self?.config.categories = categories
        }, fail: { error in
            completion([], error)
        })
    }
    
    public func modifyConfig(config: Config) {
        var newConfig = config
        newConfig.accountID = self.config.accountID
        newConfig.token = self.config.token
        self.config = newConfig
        isOverrideConfig = true
    }
    
    public func getBoundsForImage(image: UIImage,
                                  feeds: [String],
                                  success: @escaping ([ImageBounds]) -> Void,
                                  fail: ((SyteError) -> Void)?) {
        guard let accountID = config.accountID, let token = config.token else {
            fail?(UnauthorizationError(config: config))
            return
        }
        HttpClient.shared.uploadImage(
            image: image,
            params: generateParamsString(),
            accountID: accountID,
            token: token,
            feeds: feeds,
            success: success,
            fail: fail)
    }
    
    public func getBoundsForImage(fromUrl imageUrl: String,
                                  feeds: [String],
                                  success: @escaping ([ImageBounds]) -> Void,
                                  fail: ((SyteError) -> Void)?) {
        guard let accountID = config.accountID, let token = config.token else {
            fail?(UnauthorizationError(config: config))
            return
        }
        HttpClient.shared.uploadImage(
            fromUrl: imageUrl,
            params: generateParamsString(),
            accountID: accountID,
            token: token,
            feeds: feeds,
            success: success,
            fail: fail)
    }
    
    public func getOffers(url: String, success: @escaping (OfferDetails) -> Void,
                          fail: ((SyteError) -> Void)?) {
        HttpClient.shared.getOffers(api: url, success: success, fail: fail)
    }
}

public extension SyteAI {
    convenience init(accountID: String, token: String) {
        self.init()
        config.accountID = accountID
        config.token = token
        
        HttpClient.shared.getAccount(
            accountID: accountID,
            token: token,
            success: { [weak self] (config) in
                self?.config = config
            },
            fail: nil)
    }
    
    func setDebugMode(_ isOn: Bool) {
        Logger.isDebugging = isOn
    }
    
    func generateParamsString() -> String {
        var params = "";
        if isOverrideConfig {
            params += "&force_gender=\(config.gender.rawValue)"
            if let cat = config.category {
                params += "&force_cats=\(cat)"
            }
            if config.currency.count == 3 {
                params += "&force_currency=\(config.currency)"
            }
        }
        
        return params;
    }
}
