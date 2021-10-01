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
import Toast_Swift

class WildSearchViewController: UIViewController, UIImagePickerControllerDelegate {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var fetchOffersSegmentControll: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    private var imageToSend: UIImage?
    
    private var boundsResult: BoundsResult? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Wild Search"
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.registerNib(with: SyteBoundsResponceTableViewCell.self)
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
        guard SyteManager.shared.isInitialized else { return }
        guard let image = imageToSend else { return }
        SVProgressHUD.show()
        let data = ImageSearch(image: image)
        data.retrieveOffersForTheFirstBound = fetchOffersSegmentControll.selectedSegmentIndex == 0
        SyteManager.shared.getBoundsWild(requestData: data) { [weak self] response in
            SVProgressHUD.dismiss()
            self?.view.makeToast(response?.isSuccessful == true ? "Success" : "Failure: \(response?.errorMessage ?? "No Errors")")
            guard let bounds = response?.data else { return }
            self?.boundsResult = bounds
            self?.tableView.isHidden = false
        }
    }
    
}

// MARK: UINavigationControllerDelegate

extension WildSearchViewController: UINavigationControllerDelegate {}

// MARK: UITableViewDataSource

extension WildSearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return boundsResult?.bounds?.count ?? 0
        case 1:
            return boundsResult?.firstBoundItemsResult?.items?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SyteBoundsResponceTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        
        if indexPath.section == 0 {
            guard let bounds = boundsResult?.bounds else { return cell }
            let value = bounds[indexPath.row]
            cell.setContent(with: value)
        } else if indexPath.section == 1 {
            guard let items = boundsResult?.firstBoundItemsResult?.items else { return cell }
            let value = items[indexPath.row]
            cell.setContent(with: value)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return boundsResult?.bounds?.isEmpty ?? true ? nil : "BOUNDS"
        case 1:
            return boundsResult?.firstBoundItemsResult?.items?.isEmpty ?? true ? nil : "ITEMS"
        default:
            return nil
        }
    }
    
}
