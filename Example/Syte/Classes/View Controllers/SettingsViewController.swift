//
//  SettingsViewController.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 04.10.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Syte
import SVProgressHUD

class SettingsViewController: UIViewController {
    
    @IBOutlet private weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Syte Platform Settings"
    }
    
    private func getSettings() {
        textView.text = ""
        SVProgressHUD.show()
        SyteManager.shared.getSytePlatformSettings { [weak self] result in
            SVProgressHUD.dismiss()
            self?.view.makeToast(result.isSuccessful ? "Success" : "Failure: \(result.errorMessage ?? "No Errors")")
            guard let settings = result.data else { return }
            self?.textView.text = String(settings.description)
        }
        
    }
    
    // MARK: Actions
    
    @IBAction private func getSettingsButtonPressed(_ sender: Any) {
        getSettings()
    }
    
}
