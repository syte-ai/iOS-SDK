//
//  TextSearchClient.swift
//  Syte
//
//  Created by Artur Tarasenko on 22.09.2021.
//

import Foundation
import PromiseKit

// swiftlint:disable large_tuple

class TextSearchClient {
    
    private let autoCompleteIntervalMS = 500
    private let syteRemoteDataSource: SyteRemoteDataSource
    
    private var isAutoCompleteAvailable = true
    private var nextQuery: (query: String?,
                            lang: String?,
                            completion: ((SyteResult<AutoCompleteResult>) -> Void)?) = (nil, nil, nil)
    
    var allowAutoCompletionQueue = false
    
    init(syteRemoteDataSource: SyteRemoteDataSource, allowAutoCompletionQueue: Bool) {
        self.allowAutoCompletionQueue = allowAutoCompletionQueue
        self.syteRemoteDataSource = syteRemoteDataSource
    }
    
    func getPopularSearch(lang: String, completion: @escaping (SyteResult<[String]>) -> Void) {
        do {
            try InputValidator.validateInput(lang: lang)
            syteRemoteDataSource.getPopularSearch(lang: lang, completion: completion)
        } catch let error {
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    func getTextSearch(textSearch: TextSearch, completion: @escaping (SyteResult<TextSearchResult>) -> Void) {
        do {
            try InputValidator.validateInput(requestData: textSearch)
            syteRemoteDataSource.getTextSearch(textSearch: textSearch, completion: completion)
        } catch let error {
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    func getAutoComplete(query: String, lang: String, completion: @escaping (SyteResult<AutoCompleteResult>) -> Void) {
        do {
            try InputValidator.validateInput(query: query, lang: lang)
            if isAutoCompleteAvailable {
                isAutoCompleteAvailable = false
                syteRemoteDataSource.getAutoComplete(query: query, lang: lang) { result in
                    completion(result)
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(self.autoCompleteIntervalMS), execute: self.checkAutoUpdateQueue)
                }
            } else if allowAutoCompletionQueue {
                nextQuery = (query, lang, completion)
            }
        } catch let error {
            completion(.failureResult(message: error.localizedDescription))
        }
    }
    
    private func checkAutoUpdateQueue() {
        isAutoCompleteAvailable = true
        guard let query = nextQuery.query,
              let lang = nextQuery.lang,
              let completion = nextQuery.completion else { return }
        getAutoComplete(query: query, lang: lang, completion: completion)
        nextQuery = (nil, nil, nil)
    }
    
}
// swiftlint:enable large_tuple
