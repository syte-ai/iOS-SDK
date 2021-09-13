//
//  SyteExampleTableViewCell.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 13.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class SyteExampleTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var syteButton: RoundedButton!
    
    func setButtonTitle(title: String) {
        syteButton.setTitle(title, for: .normal)
    }
    
}
