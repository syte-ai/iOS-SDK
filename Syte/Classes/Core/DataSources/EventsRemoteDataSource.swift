//
//  EventsRemoteDataSource.swift
//  Syte
//
//  Created by Artur Tarasenko on 15.09.2021.
//

import Foundation
import PromiseKit

class EventsRemoteDataSource: BaseRemoteDataSource {
    
    private static let tag = String(describing: EventsRemoteDataSource.self)
    
    private let eventsService = EventsService()
    
    override init(configuration: SyteConfiguration) {
        super.init(configuration: configuration)
    }
    
    public func fire(event: BaseSyteEvent) {
        renewTimestamp()
        firstly {
            eventsService.fire(event: event,
                               accountId: configuration.accountId,
                               signature: configuration.signature,
                               sessionId: String(configuration.sessionId),
                               userId: configuration.userId)
        }.done { response in
            SyteLogger.d(tag: EventsRemoteDataSource.tag, message: "Fire event response code - \(response.resultCode)")
        }.catch { error in
            SyteLogger.e(tag: EventsRemoteDataSource.tag, message: "Error while firing event: \(error.localizedDescription)")
        }
    }
    
}
