//
//  ViewController.swift
//  Syte
//
//  Created by arturtarasenko on 08/20/2021.
//  Copyright (c) 2021 arturtarasenko. All rights reserved.
//

import UIKit
import Syte

class ViewController: UIViewController, UIImagePickerControllerDelegate {
    
    @IBOutlet private weak var textView: UITextView!
    
    private let syte = InitSyte()
    private var resporseString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleResponse(notification:)), name: NSNotification.Name(rawValue: "test_response"), object: nil)
    }
    
    @IBAction private func sendInitializeRequestButtonPressed(_ sender: Any) {
        textView.text.removeAll()
        let configuration = SyteConfiguration(accountId: "9165", signature: "601c206d0a7f780efb9360f3")
        textView.text = "InitializeRequest\n accountId = 9165\n signature = 601c206d0a7f780efb9360f3\n"
        syte.startSession(configuration: configuration) { [weak self] result in
            let settings = self?.syte.getSytePlatformSettings()
            var text = "---Result---\n\n\(result.data == true ? "Success" : "Failure")\n\n"
            text += "---Response data---\n\n"
            text += self?.resporseString ?? ""
            text += "\n\n---Parsed data---\n\n"
            text += String(describing: settings)
            self?.textView.text += text
        }
    }
    
    @IBAction func searchByImageUrlButtonPressed(_ sender: Any) {
        textView.text.removeAll()
        let imageSearchRequestData = UrlImageSearch(imageUrl: "https://cdn-images.farfetch-contents.com/13/70/55/96/13705596_18130188_1000.jpg", productType: .discoveryButton)
        imageSearchRequestData.sku = "13705596"
        imageSearchRequestData.coordinates = CropCoordinates(x1: 0.35371503233909607, y1: 0.32111090421676636, x2: 0.6617449522018433, y2: 0.6626847386360168)
        textView.text = "Search By ImageUrl\n imageUrl = https://cdn-images.farfetch-contents.com/13/70/55/96/13705596_18130188_1000.jpg\n sku = 13705596\n crop = x1: 0.35371503233909607, y1: 0.32111090421676636, x2: 0.6617449522018433, y2: 0.6626847386360168\n"
        imageSearchRequestData.retrieveOffersForTheFirstBound = true
        syte.getBounds(requestData: imageSearchRequestData) { [weak self] result in
            var text = "---Result---\n\n\(result.isSuccessful == true ? "Success" : "Failure")\n\n"
            text += "---Response data---\n\n"
            text += self?.resporseString ?? ""
            text += "\n\n---Parsed data---\n\n"
            text += String(describing: result.data)
            self?.textView.text += text
        }
    }
    
    @IBAction private func wildImageButtonPressed(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    
    @objc private func handleResponse(notification: NSNotification) {
        resporseString.removeAll()
        resporseString +=  (notification.userInfo?["request"] as? String ?? "") + "\n" + (notification.userInfo?["data"] as? String ?? "")
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        picker.dismiss(animated: true)
        
        let data = ImageSearch(image: image)
        syte.getBoundsWild(requestData: data) { response in
            print(response)
        }
//        guard let url = URL(string: "https://cdn-images.farfetch-contents.com/13/70/55/96/13705596_18130188_1000.jpg") else { return }
//        do {
//            let data = try Data(contentsOf: url)
//            let img = UIImage(data: data)
//            guard let imgUnw = img else { return }
//            let requestData = ImageSearch(image: imgUnw)
//            syte.getBoundsWild(requestData: requestData) { response in
//                print(response)
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
        
    }
    
}

extension UIViewController: UINavigationControllerDelegate {}
