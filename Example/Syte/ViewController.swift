//
//  ViewController.swift
//  Syte
//
//  Created by alexvnukov on 08/20/2021.
//  Copyright (c) 2021 alexvnukov. All rights reserved.
//

import UIKit
import Syte

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let syte = InitSyte()
        let configuration = SyteConfiguration(accountId: "9165", signature: "601c206d0a7f780efb9360f3")
        syte.startSessionAsync(configuration: configuration) { result in
            print("\(result)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
