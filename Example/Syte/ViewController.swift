//
//  ViewController.swift
//  Syte
//
//  Created by arturtarasenko on 08/20/2021.
//  Copyright (c) 2021 arturtarasenko. All rights reserved.
//

import UIKit
import Syte
import Toast_Swift

class ViewController: UIViewController, UIImagePickerControllerDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    
    public enum SyteScreens: Int, CaseIterable {
        
        case configuration = 0, url, wild, similars, shopTheLook, personalizations, events, autocomplete, popupar, textSearch
        
        func title() -> String {
            switch self {
            case .configuration:
                return "CONFIGURATION"
            case .url:
                return "URL SEARCH"
            case .wild:
                return "WILD SEARCH"
            case .similars:
                return "GET SIMILARS"
            case .shopTheLook:
                return "SHOP THE LOOK"
            case .personalizations:
                return "PERSONALIZATION"
            case .events:
                return "FIRE EVENTS"
            case .autocomplete:
                return "AUTOCOMPLETE"
            case .popupar:
                return "POPULAR SEARCHES"
            case .textSearch:
                return "TEXT SEARCH"
            }
        }
        
    }
    
    private var resporseString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuteTableView()
        initSyte()
    }
    
    private func configuteTableView() {
        tableView.tableFooterView = UIView()
        tableView.registerNib(with: SyteExampleTableViewCell.self)
    }
    
    private func initSyte() {
        SyteManager.shared.initialize { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
        }
    }
    
    // swiftlint:disable function_body_length
    private func fireEvents() {
        let eventCheckoutStart = EventCheckoutStart(price: 2,
                                                    currency: "UAH",
                                                    productList: [Product(sku: "test", quantity: 2, price: 2)],
                                                    pageName: "sdk-test")
        SyteManager.shared.fire(event: eventCheckoutStart)
        
        let eventBBClick = EventBBClick(imageUrl: "url",
                                        category: "category",
                                        gender: "gender",
                                        catalog: Catalog.general.getName(),
                                        pageName: "sdk-test")
        SyteManager.shared.fire(event: eventBBClick)
        
        let eventBBShowLayout = EventBBShowLayout(imageUrl: "url", numOfBBs: 2, pageName: "sdk-test")
        SyteManager.shared.fire(event: eventBBShowLayout)
        
        let eventBBShowResults = EventBBShowResults(imageUrl: "url", category: "category", resultsCount: 2, pageName: "sdk-test")
        SyteManager.shared.fire(event: eventBBShowResults)
                                    
        let eventCameraButtonClick = EventCameraButtonClick(placement: Placement.default.getName(), pageName: "sdk-test")
        SyteManager.shared.fire(event: eventCameraButtonClick)
        
        let eventCameraButtonImpression = EventCameraButtonImpression(pageName: "sdk-test")
        SyteManager.shared.fire(event: eventCameraButtonImpression)
        
        let eventCheckoutComplete = EventCheckoutComplete(id: "1",
                                                          value: 2,
                                                          currency: "USD",
                                                          productList: [Product(sku: "test", quantity: 2, price: 2)],
                                                          pageName: "sdk-test")
        SyteManager.shared.fire(event: eventCheckoutComplete)
                                    
        let eventDiscoveryButtonClick = EventDiscoveryButtonClick(imageSrc: "src", placement: Placement.default.getName(), pageName: "sdk-test")
        SyteManager.shared.fire(event: eventDiscoveryButtonClick)
        
        let eventDiscoveryButtonImpression = EventDiscoveryButtonImpression(pageName: "sdk-test")
        SyteManager.shared.fire(event: eventDiscoveryButtonImpression)
                                    
        let eventOfferClick = EventOfferClick(sku: "sku", position: 123, pageName: "sdk-test")
        SyteManager.shared.fire(event: eventOfferClick)
        
        let eventPageView = EventPageView(sku: "PZZ70556-105", pageName: "sdk-test")
        SyteManager.shared.fire(event: eventPageView)
        
        let eventProductsAddedToCart = EventProductsAddedToCart(productList: [Product(sku: "test", quantity: 2, price: 2)], pageName: "sdk-test")
        SyteManager.shared.fire(event: eventProductsAddedToCart)
        
        let eventShopTheLookOfferClick = EventShopTheLookOfferClick(sku: "sku", position: 123, pageName: "sdk-test")
        SyteManager.shared.fire(event: eventShopTheLookOfferClick)
        
        let eventShopTheLookShowLayout = EventShopTheLookShowLayout(resultsCount: 3, pageName: "sdk-test")
        SyteManager.shared.fire(event: eventShopTheLookShowLayout)
                                    
        let eventSimilarItemsOfferClick = EventSimilarItemsOfferClick(sku: "sku", position: 1, pageName: "sdk-test")
        SyteManager.shared.fire(event: eventSimilarItemsOfferClick)
        
        let eventSimilarItemsShowLayout = EventSimilarItemsShowLayout(resultsCount: 2, pageName: "sdk-test")
        SyteManager.shared.fire(event: eventSimilarItemsShowLayout)
        
        let eventTextShowResults = EventTextShowResults(query: "text",
                                                        type: TextSearchEventType.popularSearch.getName(),
                                                        exactCount: 10,
                                                        pageName: "sdk-test")
        SyteManager.shared.fire(event: eventTextShowResults)
        
        let baseEvent = BaseSyteEvent(name: "custom_event", syteUrlReferer: "sdk-test", tag: EventsTag.syte_ios_sdk)
        SyteManager.shared.fire(event: baseEvent)
        
        view.makeToast("Events fired!")
    }
    // swiftlint:enable function_body_length
    
    // swiftlint:disable cyclomatic_complexity
    private func switchToScreen(type: SyteScreens) {
        guard SyteManager.shared.isInitialized else { return }
        switch type {
        case .configuration:
            let vc = MainStoryboard.configurationViewController
            navigationController?.pushViewController(vc, animated: true)
        case .url:
            let vc = MainStoryboard.urlSearchViewController
            navigationController?.pushViewController(vc, animated: true)
        case .wild:
            let vc = MainStoryboard.wildSearchViewController
            navigationController?.pushViewController(vc, animated: true)
        case .similars:
            let vc = MainStoryboard.similarsViewController
            navigationController?.pushViewController(vc, animated: true)
        case .shopTheLook:
            let vc = MainStoryboard.shopTheLookViewController
            navigationController?.pushViewController(vc, animated: true)
        case .personalizations:
            let vc = MainStoryboard.personalizationViewController
            navigationController?.pushViewController(vc, animated: true)
        case .events:
            fireEvents()
        case .autocomplete:
            let vc = MainStoryboard.autoCompleteViewController
            navigationController?.pushViewController(vc, animated: true)
        case .popupar:
            let vc = MainStoryboard.popularSearchViewController
            navigationController?.pushViewController(vc, animated: true)
        case .textSearch:
            let vc = MainStoryboard.textSearchViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    // swiftlint:enableb cyclomatic_complexity
    
}

// MARK: UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SyteScreens.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SyteExampleTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let exapmleValue = SyteScreens(rawValue: indexPath.row) ?? .configuration
        cell.setButtonTitle(title: exapmleValue.title())
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let exapmleValue = SyteScreens(rawValue: indexPath.row) else { return }
        switchToScreen(type: exapmleValue)
    }
    
}
