//
//  Features.swift
//  Syte
//
//  Created by Artur Tarasenko on 25.08.2021.
//

import Foundation

public class Features: Codable {
    
    public var collaborativeFiltering: CollaborativeFiltering?
    public var sessionBased: SessionBased?
    public var associationRules: AssociationRules?
    public var cameraHandler: CameraHandler?
    public var boundingBox: BoundingBox?
    public var historyRouter: HistoryRouter?
    public var shopTheLook: ShopTheLookSettings?
    public var similarItems: SimilarItems?
    public var relatedItems: RelatedItems?
    public var recommendations: Recommendations?
    public var getSkuConfig: GetSkuConfig?
    public var productCard: ProductCard?
    public var personalization: PersonalizationResponse?
    public var currency: Currency?
    public var discoveryButton: DiscoveryButton?

}
