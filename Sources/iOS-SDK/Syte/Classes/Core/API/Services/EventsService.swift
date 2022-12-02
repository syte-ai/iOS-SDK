//
//  EventsService.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation
import Moya
import PromiseKit

protocol EventsServiceProtocol: AnyObject {
    func fire(event: BaseSyteEvent, accountId: String, signature: String, sessionId: String, userId: String) -> Promise<SyteResult<Bool>>
}

class EventsService: EventsServiceProtocol {
    
    private let service = MoyaProvider<EventsProvider>()

    func fire(event: BaseSyteEvent, accountId: String, signature: String, sessionId: String, userId: String) -> Promise<SyteResult<Bool>> {
        let body = event.getRequestBodyString().data(using: .utf8) ?? Data()
        return service.request(.fireEvent(tags: event.getTagsString(),
                                          name: event.name,
                                          accountId: accountId,
                                          signature: signature,
                                          sessionId: sessionId,
                                          userId: userId,
                                          syteUrlReferer: event.syteUrlReferer,
                                          body: body)).map { response -> SyteResult<Bool> in
            let result = SyteResult<Bool>()
            result.resultCode = response.statusCode
            do {
                _ = try response.filterSuccessfulStatusCodes()
                result.data = true
                result.isSuccessful = true
            } catch {
                let stringResponse = try? response.mapString()
                result.errorMessage = stringResponse ?? error.localizedDescription
                result.data = false
            }
            return result
        }
    }
    
}
