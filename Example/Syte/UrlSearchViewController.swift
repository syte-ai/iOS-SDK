//
//  UrlSearchViewController.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 13.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Syte
import SVProgressHUD

class UrlSearchViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet private weak var urlTextField: UITextField!
    @IBOutlet private weak var skuTextField: UITextField!
    @IBOutlet private weak var x1TextField: UITextField!
    @IBOutlet private weak var y1TextField: UITextField!
    @IBOutlet private weak var x2TextField: UITextField!
    @IBOutlet private weak var y2TextField: UITextField!
    @IBOutlet private weak var fetchFirstBoundSegmentControll: UISegmentedControl!
    @IBOutlet private weak var responseTextView: UITextView!
    
    // MARK: Actions
    
    @IBAction private func getBoundsButtonPressed(_ sender: Any) {
        guard SyteMaganer.shared.isInitialized else { return }
        SVProgressHUD.show()
        responseTextView.text?.removeAll()
        let imageSearchRequestData = UrlImageSearch(imageUrl: urlTextField.text ?? "", productType: .discoveryButton)
        imageSearchRequestData.sku = skuTextField.text ?? ""
        
        if let x1 = Double(x1TextField.text ?? ""),
           let x2 = Double(x2TextField.text ?? ""),
           let y1 = Double(y1TextField.text ?? ""),
           let y2 = Double(y2TextField.text ?? "") {
        imageSearchRequestData.coordinates = CropCoordinates(x1: x1, y1: y1, x2: x2, y2: y2)
        }
        
        imageSearchRequestData.retrieveOffersForTheFirstBound = fetchFirstBoundSegmentControll.selectedSegmentIndex == 0
        SyteMaganer.shared.getBounds(requestData: imageSearchRequestData) { [weak self] result in
            var text = "---Result---\n\n\(result?.isSuccessful == true ? "Success" : "Failure")\n\n"
            text += "\n\n---Error---\n\n\(result?.errorMessage ?? "No errors")"
            text += "\n\n---Parsed data---\n\n"
            text += String(describing: result?.data)
            self?.responseTextView.text = text
            self?.responseTextView.isHidden = false
            SVProgressHUD.dismiss()
        }
    }
    
}
