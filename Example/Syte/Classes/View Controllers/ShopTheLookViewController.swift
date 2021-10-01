//
//  ShopTheLookViewController.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 20.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Syte
import SVProgressHUD
import Toast_Swift

class ShopTheLookViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet private weak var urlTextField: UITextField!
    @IBOutlet private weak var skuTextField: UITextField!
    @IBOutlet private weak var limitTextField: UITextField!
    @IBOutlet private weak var urlRefererTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    
    private var items: ShopTheLookResult? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shop The Look"
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
    
    @IBAction private func getShopTheLookButtonPressed(_ sender: Any) {
        guard SyteManager.shared.isInitialized else { return }
        guard let sku = skuTextField.text else { return }
        guard let imageUrl = urlTextField.text else { return }
        SVProgressHUD.show()
        
        let shopTheLook = ShopTheLook(sku: sku, imageUrl: imageUrl)
        shopTheLook.personalizedRanking = !SyteManager.shared.getViewedProducts().isEmpty
        
        guard validateInputs() else {
            view.makeToast("Wrong input")
            return
        }
        
        if let limit = limitTextField.text,
           let limitInt = Int(limit) {
            shopTheLook.limit = limitInt
        }
        
        if let referer = urlRefererTextField.text {
            shopTheLook.syteUrlReferer = referer
        }
        
        SyteManager.shared.getShopTheLook(shopTheLook: shopTheLook) { [weak self] result in
            SVProgressHUD.dismiss()
            self?.view.makeToast(result?.isSuccessful == true ? "Success" : "Failure: \(result?.errorMessage ?? "No Errors")")
            guard let items = result?.data else { return }
            self?.items = items
            self?.tableView.isHidden = false
        }
    }
    
}

// MARK: UITableViewDataSource

extension ShopTheLookViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.getItemsForAllLabels().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SyteBoundsResponceTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        
        guard let items = items?.getItemsForAllLabels() else { return cell }
        let value = items[indexPath.row]
        cell.setContent(with: value)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ITEMS"
    }
    
}
