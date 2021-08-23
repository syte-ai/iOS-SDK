//
//  InputValidator.swift
//  Syte
//
//  Created by Artur Tarasenko on 20.08.2021.
//

import Foundation

class InputValidator {
    
    public static func validateInput(/* requestData: ImageSearch */) throws {
//        guard let data = requestData else { throw SyteError.generalError(message: "Request data can not be null.") }
//        guard let imageUri = requestData.getImageUri() else { throw SyteError.generalError(message: "Image URI can not be null.") }
    }
    
//    public static func validateInput(/* requestData: UrlImageSearch */) throws {
//        guard let data = requestData else { throw SyteError.generalError(message: "Request data can not be null.") }
//        guard let imageUri = requestData.getImageUri() else { throw SyteError.generalError(message: "Image URI can not be null.") }
        //        guard let productType = requestData.getProductType() else { throw SyteError.generalError(message: "Product type can not be null.") }
//    }
    
//    public static func validateInput(/* bound: Bound */) throws {
//        guard let bound = bound else { throw SyteError.generalError(message: "Bound can not be null.") }
//    }

    public static func validateInput(configuration: SyteConfiguration) throws {
//        guard let accountId = configuration.getAccountId() else { throw SyteError.generalError(message: "Account ID can not be null.") }
//        guard let apiSignature = configuration.getApiSignature() else { throw SyteError.generalError(message: "Signature can not be null.") }
    }
    
//    public static func validateInput(/* requestData: SimilarProducts */) throws {
        //        guard let data = requestData else { throw SyteError.generalError(message: "Request data can not be null.") }
        //        guard let sku = requestData.getSku() else { throw SyteError.generalError(message: "SKU can not be null.") }
        //        guard let imageUrl = requestData.getImageUrl() else { throw SyteError.generalError(message: "Image URL can not be null.") }
//    }
    
//    public static func validateInput(/* requestData: ShopTheLook */) throws {
        //        guard let data = requestData else { throw SyteError.generalError(message: "Request data can not be null.") }
        //        guard let sku = requestData.getSku() else { throw SyteError.generalError(message: "SKU can not be null.") }
        //        guard let imageUrl = requestData.getImageUrl() else { throw SyteError.generalError(message: "Image URL can not be null.") }
//    }
    
//    public static func validateInput(/* requestData: Personalization */) throws {
        //        guard let data = requestData else { throw SyteError.generalError(message: "Request data can not be null.") }
//    }
    
    public static func validateInput(string: String?) throws {
        guard let stringValue = string, stringValue.isEmpty == false else { throw SyteError.generalError(message: "Viewed product can not be empty.") }
    }
    
//    public static void validateInput(Context context) throws SyteWrongInputException {
//        if (context == null) {
//            throw new SyteWrongInputException("Context can not be null.");
//        }
//    }

}
