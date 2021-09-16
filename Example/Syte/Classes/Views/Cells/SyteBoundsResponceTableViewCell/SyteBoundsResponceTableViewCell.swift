//
//  SyteBoundsResponceTableViewCell.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 16.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Syte

class SyteBoundsResponceTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var contentLabel: UILabel!
    
    func setContent(with bound: Bound) {
        var text = ""
        text += "offersUrl: \(bound.offersUrl ?? "")\n\n"
        text += "gender: \(bound.gender ?? "")\n\n"
        text += "catalog: \(bound.catalog ?? "")\n\n"
        text += "label: \(bound.label ?? "")\n\n"
        text += "b0: \(bound.b0 ?? [])\n\n"
        text += "b1: \(bound.b1 ?? [])\n\n"
        contentLabel.text = text
    }
    
    func setContent(with item: Item) {
        var text = ""
        text += "floatPrice: \(item.floatPrice ?? 0)\n\n"
        text += "originalPrice: \(item.originalPrice ?? "")\n\n"
        text += "parentSku: \(item.parentSku ?? "")\n\n"
        text += "merchant: \(item.merchant ?? "")\n\n"
        text += "description: \(item.description ?? "")\n\n"
        text += "offer: \(item.offer ?? "")\n\n"
        text += "price: \(item.price ?? "")\n\n"
        text += "bbCategories: \(item.bbCategories ?? [""])\n\n"
        text += "id: \(item.id ?? "")\n\n"
        text += "floatOriginalPrice: \(item.floatOriginalPrice ?? 0)\n\n"
        text += "sku: \(item.sku ?? "")\n\n"
        text += "brand: \(item.brand ?? "")\n\n"
        contentLabel.text = text
    }
    
}
