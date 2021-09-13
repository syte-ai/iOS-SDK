//
//  RoundedButton.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 13.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.9 : 1.0
        }
    }
    
    override func awakeFromNib() {
        let normalColor = UIColor.black
        let titleColor = UIColor.white
        setTitleColor(titleColor, for: .normal)
        setTitleColor(titleColor, for: .highlighted)
        titleLabel?.font = .systemFont(ofSize: 14)
        backgroundColor = normalColor
        layer.cornerRadius = frame.height / 2.0
    }
    
}
