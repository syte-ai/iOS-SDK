//
//  InputValidator.swift
//  Syte
//
//  Created by Artur Tarasenko on 20.08.2021.
//

import Foundation

class InputValidator {
    
    public static func validateInput(requestData: UrlImageSearch) throws {
        guard requestData.imageUrl.isEmpty == false else { throw SyteError.wrongInput(message: "Image URI can not be empty.") }
    }
    
    public static func validateInput(configuration: SyteConfiguration) throws {
        guard configuration.accountId.isEmpty == false else { throw SyteError.wrongInput(message: "Account ID can not be empty.") }
        guard configuration.signature.isEmpty == false else { throw SyteError.wrongInput(message: "Signature can not be empty.") }
    }
    
    public static func validateInput(requestData: SimilarProducts) throws {
        guard requestData.sku.isEmpty == false else { throw SyteError.wrongInput(message: "SKU can not be empty.") }
        guard requestData.imageUrl.isEmpty == false else { throw SyteError.wrongInput(message: "Image URL can not be empty.") }
    }
    
    public static func validateInput(requestData: ShopTheLook) throws {
        guard requestData.sku.isEmpty == false else { throw SyteError.wrongInput(message: "SKU can not be empty.") }
        guard requestData.imageUrl.isEmpty == false else { throw SyteError.wrongInput(message: "Image URL can not be empty.") }
    }
    
    public static func validateInput(requestData: TextSearch) throws {
        guard requestData.query.isEmpty == false else { throw SyteError.wrongInput(message: "Query can not be empty.") }
    }
    
    public static func validateInput(string: String) throws {
        guard string.isEmpty == false else { throw SyteError.wrongInput(message: "Viewed product can not be empty.") }
    }
    
    public static func validateInput(query: String, lang: String) throws {
        guard query.isEmpty == false else { throw SyteError.wrongInput(message: "Query can not be empty.") }
        guard lang.isEmpty == false else { throw SyteError.wrongInput(message: "Query can not be empty.") }
    }
    
    public static func validateInput(lang: String) throws {
        guard lang.isEmpty == false else { throw SyteError.wrongInput(message: "Query can not be empty.") }
    }
    
}
