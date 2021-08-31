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
    
    @IBOutlet private weak var textView: UITextView!
    
    private let syte = InitSyte()
    private var resporseString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleResponse(notification:)), name: NSNotification.Name(rawValue: "test_response"), object: nil)
    }

    @IBAction private func sendInitializeRequestButtonPressed(_ sender: Any) {
        let configuration = SyteConfiguration(accountId: "9165", signature: "601c206d0a7f780efb9360f3")
        syte.startSessionAsync(configuration: configuration) { [weak self] result in
//            print("startSessionAsync result = \(String(describing: result.data))")
            let settings = self?.syte.getSytePlatformSettings()
//            print("settings = \(String(describing: settings))")
            var text = "---Response data---\n\n"
            text += self?.resporseString ?? ""
            text += "\n\n---Parsed data---\n\n"
            text += String(describing: settings)
            self?.textView.text = text
        }
    }
    
    @objc private func handleResponse(notification: NSNotification) {
        resporseString = notification.userInfo?["data"] as? String ?? ""
    }
    
}
