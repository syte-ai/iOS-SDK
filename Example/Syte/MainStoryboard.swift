//
//  MainStoryboard.swift
//  Syte_Example
//
//  Created by Artur Tarasenko on 13.09.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class MainStoryboard: UIStoryboard {
    
    static var configurationViewController: ConfigurationViewController {
        let controller: ConfigurationViewController = instance.instantiate()
        
        return controller
    }
    
    static var urlSearchViewController: UrlSearchViewController {
        let controller: UrlSearchViewController = instance.instantiate()
        
        return controller
    }
    
    static var wildSearchViewController: WildSearchViewController {
        let controller: WildSearchViewController = instance.instantiate()
        
        return controller
    }
    
}
