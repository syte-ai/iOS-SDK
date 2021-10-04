//
//  TextSearchViewController.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 23.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Syte
import SVProgressHUD

class TextSearchViewController: UIViewController {
    
    @IBOutlet private weak var textField: UITextField!
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var result: TextSearchResult? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Text search"
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func search(text: String) {
        SVProgressHUD.show()
        
        SyteManager.shared.getTextSearch(query: text) { [weak self] result in
            SVProgressHUD.dismiss()
            self?.view.makeToast(result.isSuccessful ? "Success" : "Failure: \(result.errorMessage ?? "No Errors")")
            guard let items = result.data else { return }
            self?.result = items
        }
    }
    
    @IBAction private func searchButtonPressed(_ sender: Any) {
        guard let text = textField.text else { return }
        search(text: text)
    }
    
}

// MARK: UITableViewDataSource

extension TextSearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.result?.hits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let items = result?.result?.hits else { return cell }
        let value = items[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = value.title

        return cell
    }
    
}
