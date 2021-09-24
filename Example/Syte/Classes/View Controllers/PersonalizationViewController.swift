//
//  PersonalizationViewController.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 20.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Syte
import SVProgressHUD
import Toast_Swift

class PersonalizationViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var items: PersonalizationResult? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        title = "Personalization"
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.registerNib(with: SyteBoundsResponceTableViewCell.self)
    }
    
    // MARK: Actions
    
    @IBAction private func getPersonalizationButtonPressed(_ sender: Any) {
        guard SyteMaganer.shared.isInitialized else { return }
        SVProgressHUD.show()

        let personalization = Personalization()
    
        SyteMaganer.shared.getPersonalization(personalization: personalization) { [weak self] result in
            SVProgressHUD.dismiss()
            self?.view.makeToast(result?.isSuccessful == true ? "Success" : "Failure: \(result?.errorMessage ?? "No Errors")")
            guard let items = result?.data else { return }
            self?.items = items
            self?.tableView.isHidden = false
        }
    }
    
}

// MARK: UITableViewDataSource

extension PersonalizationViewController: UITableViewDataSource {
    
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
