//
//  ConfigurationViewController.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 13.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SVProgressHUD

class ConfigurationViewController: UIViewController {
    
    @IBOutlet private weak var localeTextField: UITextField!
    @IBOutlet private weak var skuTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    @IBAction private func addSkuButtonPressed(_ sender: Any) {
        guard let text = skuTextField.text else { return }
        do {
            try SyteMaganer.shared.setSetViewedItem(sku: text)
            tableView.reloadData()
        } catch {
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }
    }

}

// MARK: UITableViewDataSource

extension ConfigurationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SyteMaganer.shared.getViewedProducts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let values = SyteMaganer.shared.getViewedProducts().sorted()
        cell.textLabel?.text = values[indexPath.row]
        return cell
    }
    
}
