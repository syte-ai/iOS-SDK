//
//  SyteService.swift
//  Syte
//
//  Created by Artur Tarasenko on 21.08.2021.
//

import Moya
import PromiseKit

protocol SyteServiceProtocol: class {
    func initialize(accoundId: String) -> Promise<SyteResult<SytePlatformSettings>>
}

public class SyteService: SyteServiceProtocol {
    
    private let service = MoyaProvider<SyteProvider>()
    
    func initialize(accoundId: String) -> Promise<SyteResult<SytePlatformSettings>> {
        service.request(.initialize(accountId: accoundId)).map { response -> SyteResult<SytePlatformSettings> in
            let result = SyteResult<SytePlatformSettings>()
            result.resultCode = response.statusCode
            do {
                let settings = try response.map(SytePlatformSettings.self)
                let stringResponse = (try? response.mapString()) ?? ""
                SyteLogger.v(tag: "SyteService - initialize response\n", message: stringResponse)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "test_response"), object: nil, userInfo: ["data": stringResponse])
                result.data = settings
                result.isSuccessful = true
            } catch {
                result.errorMessage = error.localizedDescription
            }
            return result
        }
    }
    
}
