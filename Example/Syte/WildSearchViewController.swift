//
//  WildSearchViewController.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 13.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Syte
import SVProgressHUD

class WildSearchViewController: UIViewController, UIImagePickerControllerDelegate {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var responseTextView: UITextView!
    @IBOutlet private weak var fetchOffersSegmentControll: UISegmentedControl!
    
    private var syte: Syte?
    private var imageToSend: UIImage?
    
    func setSyte(_ syte: Syte) {
        self.syte = syte
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        picker.dismiss(animated: true)
        
        imageToSend = image
        imageView.image = image
    }
    
    // MARK: Actions
    
    @IBAction private func loadImageButtonPressed(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    
    @IBAction private func getBoundsButtonPressed(_ sender: Any) {
        guard let syte = syte else { return }
        guard let image = imageToSend else { return }
        SVProgressHUD.show()
        let data = ImageSearch(image: image)
        data.retrieveOffersForTheFirstBound = fetchOffersSegmentControll.selectedSegmentIndex == 0
        syte.getBoundsWild(requestData: data) { [weak self] response in
            var text = "---Result---\n\n\(response.isSuccessful == true ? "Success" : "Failure")\n\n"
            text += "\n\n---Error---\n\n\(response.errorMessage ?? "No errors")"
            text += "\n\n---Parsed data---\n\n"
            text += String(describing: response.data)
            self?.responseTextView.text = text
            self?.responseTextView.isHidden = false
            SVProgressHUD.dismiss()
        }
    }
    
}

// MARK: UINavigationControllerDelegate

extension WildSearchViewController: UINavigationControllerDelegate {}
