//
//  InputValidator.swift
//  Syte
//
//  Created by Artur Tarasenko on 20.08.2021.
//

import Foundation

class InputValidator {
    
//    public static func validateInput(requestData: ImageSearch) throws {
//        guard requestData.imageUri.isEmpty == false else { throw SyteError.generalError(message: "Image URI can not be empty.") }
//    }
    
    public static func validateInput(requestData: UrlImageSearch) throws {
        guard requestData.imageUrl.isEmpty == false else { throw SyteError.generalError(message: "Image URI can not be empty.") }
    }
    
//    public static func validateInput(bound: Bound) throws {
//        guard let bound = bound else { throw SyteError.generalError(message: "Bound can not be null.") }
//    }

    public static func validateInput(configuration: SyteConfiguration) throws {
        guard configuration.accountId.isEmpty == false else { throw SyteError.generalError(message: "Account ID can not be empty.") }
        guard configuration.signature.isEmpty == false else { throw SyteError.generalError(message: "Signature can not be empty.") }
    }
    
    public static func validateInput(requestData: SimilarProducts) throws {
        guard requestData.sku.isEmpty == false else { throw SyteError.generalError(message: "SKU can not be empty.") }
        guard requestData.imageUrl.isEmpty == false else { throw SyteError.generalError(message: "Image URL can not be empty.") }
    }
    
    public static func validateInput(requestData: ShopTheLook) throws {
        guard requestData.sku.isEmpty == false else { throw SyteError.generalError(message: "SKU can not be empty.") }
        guard requestData.imageUrl.isEmpty == false else { throw SyteError.generalError(message: "Image URL can not be empty.") }
    }
    
//    public static func validateInput(requestData: Personalization) throws {
//        guard let data = requestData else { throw SyteError.generalError(message: "Request data can not be null.") }
//    }
    
    public static func validateInput(string: String) throws {
        guard string.isEmpty == false else { throw SyteError.generalError(message: "Viewed product can not be empty.") }
    }

}
