//
//  UITableView + Extensions.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 13.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

// swiftlint:disable force_cast

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell> (indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueReusableView<T: UITableViewHeaderFooterView> () -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
    
    func registerNib(with celltype: UITableViewCell.Type) {
        self.register(celltype.nib, forCellReuseIdentifier: celltype.reuseIdentifier)
    }
    
    func registerNibForHeaderFooter(with celltype: UITableViewHeaderFooterView.Type) {
        self.register(celltype.nib, forHeaderFooterViewReuseIdentifier: celltype.reuseIdentifier)
    }
    
}

// swiftlint:enable force_cast
