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
import Toast_Swift

class UrlSearchViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet private weak var urlTextField: UITextField!
    @IBOutlet private weak var skuTextField: UITextField!
    @IBOutlet private weak var x1TextField: UITextField!
    @IBOutlet private weak var y1TextField: UITextField!
    @IBOutlet private weak var x2TextField: UITextField!
    @IBOutlet private weak var y2TextField: UITextField!
    @IBOutlet private weak var fetchFirstBoundSegmentControll: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    private var boundsResult: BoundsResult? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.registerNib(with: SyteBoundsResponceTableViewCell.self)
    }
    
    // MARK: Actions
    
    @IBAction private func getBoundsButtonPressed(_ sender: Any) {
        guard SyteMaganer.shared.isInitialized else { return }
        SVProgressHUD.show()
        
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
            guard let bounds = result?.data else { return }
            self?.boundsResult = bounds
            self?.tableView.isHidden = false
            self?.view.makeToast(result?.isSuccessful == true ? "Success" : "Failure: \(result?.errorMessage ?? "No Errors")")
            SVProgressHUD.dismiss()
        }
    }
    
}

// MARK: UITableViewDataSource

extension UrlSearchViewController: UITableViewDataSource {
    
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
