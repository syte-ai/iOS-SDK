//
//  AutoCompleteViewController.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 22.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Syte
import SVProgressHUD

class AutoCompleteViewController: UIViewController {
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    
    private var result: AutoCompleteResult? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Auto Complete"
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func getAutocomplete(with text: String) {
        SyteManager.shared.getAutoCompleteForTextSearch(query: text, lang: nil) { [weak self] result in
            guard let items = result.data else { return }
            self?.result = items
        }
    }
    
}

// MARK: UITableViewDataSource

extension AutoCompleteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.results?.suggestedSearchTerms?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let items = result?.results?.suggestedSearchTerms else { return cell }
        let value = items[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = value.searchTerm
        
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension AutoCompleteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let items = result?.results?.suggestedSearchTerms else { return }
        let value = items[indexPath.row]
        textField.text = value.searchTerm
        getAutocomplete(with: value.searchTerm ?? "")
    }
    
}

// MARK: UITextFieldDelegate

extension AutoCompleteViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            textField.text = updatedText
            guard !updatedText.isEmpty else { return false }
            getAutocomplete(with: updatedText)
        }
        return false
    }
    
}
