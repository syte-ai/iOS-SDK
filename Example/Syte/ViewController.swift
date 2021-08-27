//
//  ViewController.swift
//  Syte
//
//  Created by arturtarasenko on 08/20/2021.
//  Copyright (c) 2021 arturtarasenko. All rights reserved.
//

import UIKit
import Syte

class ViewController: UIViewController {
    
    private let syte = InitSyte()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction private func sendInitializeRequestButtonPressed(_ sender: Any) {
        let configuration = SyteConfiguration(accountId: "9165", signature: "601c206d0a7f780efb9360f3")
        syte.startSessionAsync(configuration: configuration) { [weak self] result in
            print("startSessionAsync result = \(String(describing: result.data))")
            let settings = self?.syte.getSytePlatformSettings()
            print("settings = \(String(describing: settings))")
        }
    }
    
}
