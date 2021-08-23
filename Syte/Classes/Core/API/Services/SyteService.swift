//
//  SyteService.swift
//  Syte
//
//  Created by Artur Tarasenko on 21.08.2021.
//

import Moya

protocol SyteServiceProtocol: class {
    
}

class SyteService: SyteServiceProtocol {
    
    let service = MoyaProvider<SyteProvider>()
    
    
}
