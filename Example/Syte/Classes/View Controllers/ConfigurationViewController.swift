//
//  ConfigurationViewController.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 13.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SVProgressHUD
import Toast_Swift

class ConfigurationViewController: UIViewController {
    
    @IBOutlet private weak var localeTextField: UITextField!
    @IBOutlet private weak var skuTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Configuration"
        localeTextField.text = SyteMaganer.shared.getLocale()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.reloadData()
    }
    
    @IBAction private func setLocaleButtonPressed(_ sender: Any) {
        guard let text = localeTextField.text else { return }
        SyteMaganer.shared.setLocale(text)
        view.makeToast("Locale changed to \(text)")
    }
    
    @IBAction private func addSkuButtonPressed(_ sender: Any) {
        guard let text = skuTextField.text else { return }
        do {
            try SyteMaganer.shared.addViewedItem(sku: text)
            view.makeToast("Sku added: \(text)")
            tableView.reloadData()
        } catch {
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }
    }
    
}

// MARK: UITableViewDataSource

extension ConfigurationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return SyteMaganer.shared.getViewedProducts().count
        } else {
            return SyteMaganer.shared.getSearchHistory().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.section == 0 {
            let values = SyteMaganer.shared.getViewedProducts().sorted()
            cell.textLabel?.text = values[indexPath.row]
        } else {
            let values = SyteMaganer.shared.getSearchHistory().sorted()
            cell.textLabel?.text = values[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "SKU'S"
        } else {
            return "SEARCH HISTORY"
        }
    }
    
}
