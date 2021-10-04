//
//  PopularSearchViewController.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 22.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Syte
import SVProgressHUD

class PopularSearchViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var result: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Popular search"
        configureTableView()
        getPopularSearches()
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func getPopularSearches() {
        SVProgressHUD.show()
        
        SyteManager.shared.getPopularSearch(lang: SyteManager.shared.getLocale()) { [weak self] result in
            SVProgressHUD.dismiss()
            self?.view.makeToast(result.isSuccessful ? "Success" : "Failure: \(result.errorMessage ?? "No Errors")")
            guard let items = result.data else { return }
            self?.result = items
        }
    }
    
}

// MARK: UITableViewDataSource

extension PopularSearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let value = result[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = value
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return result.isEmpty ? "No results" : nil
    }
    
}
