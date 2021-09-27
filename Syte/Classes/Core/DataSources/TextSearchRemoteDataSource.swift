//
//  TextSearchRemoteDataSource.swift
//  Syte
//
//  Created by Artur Tarasenko on 22.09.2021.
//

import Foundation
import PromiseKit

class TextSearchRemoteDataSource: BaseRemoteDataSource {
    
    private static let tag = String(describing: TextSearchRemoteDataSource.self)
    
    private let syteService: SyteService
    
    init(configuration: SyteConfiguration, syteService: SyteService) {
        self.syteService = syteService
        super.init(configuration: configuration)
    }
    
    func getAutoComplete(query: String, lang: String, completion: @escaping (SyteResult<AutoCompleteResult>) -> Void) {
        firstly {
            syteService.getAutoComplete(parameters: .init(accountId: configuration.accountId,
                                                          lang: lang,
                                                          signature: configuration.signature,
                                                          query: query))
        }.done { result in
            completion(result)
        }.catch { error in
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    func getPopularSearch(lang: String, completion: @escaping (SyteResult<[String]>) -> Void) {
        let configData = configuration.getStorage().getPopularSearch(lang: lang)
        if  !configData.isEmpty {
            completion(.successResult(data: [configData], code: 200))
            return
        }
        firstly {
            syteService.getPopularSearch(parameters: .init(accountId: configuration.accountId,
                                                           signature: configuration.signature,
                                                           lang: lang))
        }.done { [weak self] result in
            self?.configuration.getStorage().addPopularSearch(data: result.data ?? [], lang: lang)
            completion(result)
        }.catch { error in
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    func getTextSearch(textSearch: TextSearch, completion: @escaping (SyteResult<TextSearchResult>) -> Void) {
        firstly {
            syteService.getTextSearch(parameters: .init(accountId: configuration.accountId,
                                                        lang: textSearch.lang,
                                                        signature: configuration.signature,
                                                        query: textSearch.query,
                                                        filters: Utils.generateFiltersString(filters: textSearch.filters),
                                                        from: textSearch.from,
                                                        size: textSearch.size,
                                                        sorting: textSearch.textSearchSorting == .default ? nil : textSearch.textSearchSorting.getName(),
                                                        options: textSearch.options))
        }.done { [weak self] result in
            if result.isSuccessful, result.data != nil {
                self?.configuration.getStorage().addTextSearchTerm(term: textSearch.query)
            }
            completion(result)
        }.catch { error in
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
}
