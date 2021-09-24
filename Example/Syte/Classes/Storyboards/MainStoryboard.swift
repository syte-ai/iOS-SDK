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
    
    static var similarsViewController: SimilarsViewController {
        let controller: SimilarsViewController = instance.instantiate()
        
        return controller
    }
    
    static var shopTheLookViewController: ShopTheLookViewController {
        let controller: ShopTheLookViewController = instance.instantiate()
        
        return controller
    }
    
    static var personalizationViewController: PersonalizationViewController {
        let controller: PersonalizationViewController = instance.instantiate()
        
        return controller
    }
    
    static var autoCompleteViewController: AutoCompleteViewController {
        let controller: AutoCompleteViewController = instance.instantiate()
        
        return controller
    }
    
    static var popularSearchViewController: PopularSearchViewController {
        let controller: PopularSearchViewController = instance.instantiate()
        
        return controller
    }
    
    static var textSearchViewController: TextSearchViewController {
        let controller: TextSearchViewController = instance.instantiate()
        
        return controller
    }
    
}
