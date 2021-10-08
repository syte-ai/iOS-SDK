//
//  SimilarsViewController.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 17.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Syte
import SVProgressHUD
import Toast_Swift

class SimilarsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet private weak var urlTextField: UITextField!
    @IBOutlet private weak var skuTextField: UITextField!
    @IBOutlet private weak var limitTextField: UITextField!
    @IBOutlet private weak var urlRefererTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    
    private var items: SimilarProductsResult? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Similars"
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.registerNib(with: SyteBoundsResponceTableViewCell.self)
    }
    
    private func validateInputs() -> Bool {
        guard let limit = limitTextField.text,
              Int(limit) != nil else { return false }
        
        guard let url = urlTextField.text else { return false }
        guard let referer = urlRefererTextField.text else { return false }
        guard let sku = skuTextField.text else { return false }
        return !referer.isEmpty && (!url.isEmpty || !sku.isEmpty)
    }
    
    // MARK: Actions
    
    @IBAction private func getSimilarsButtonPressed(_ sender: Any) {
        guard let sku = skuTextField.text else { return }
        guard let imageUrl = urlTextField.text else { return }
        SVProgressHUD.show()
        
        let similarProducts = SimilarProducts(sku: sku, imageUrl: imageUrl)
        similarProducts.personalizedRanking = !SyteManager.shared.getViewedProducts().isEmpty
        
        guard validateInputs() else {
            view.makeToast("Wrong input")
            return
        }
        
        if let limit = limitTextField.text,
           let limitInt = Int(limit) {
            similarProducts.limit = limitInt
        }
        
        if let referer = urlRefererTextField.text {
            similarProducts.syteUrlReferer = referer
        }
        
        SyteManager.shared.getSimilarProducts(similarProducts: similarProducts) { [weak self] result in
            SVProgressHUD.dismiss()
            self?.view.makeToast(result.isSuccessful ? "Success" : "Failure: \(result.errorMessage ?? "No Errors")")
            guard let items = result.data else { return }
            self?.items = items
            self?.tableView.isHidden = false
        }
    }
    
}

// MARK: UITableViewDataSource

extension SimilarsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SyteBoundsResponceTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        
        guard let items = items?.data else { return cell }
        let value = items[indexPath.row]
        cell.setContent(with: value)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ITEMS"
    }
    
}
