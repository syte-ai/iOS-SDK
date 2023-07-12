//
//  Aggregations.swift
//  Syte
//
//  Created by Artur Tarasenko on 23.09.2021.
//

import Foundation

public class Aggregations: Codable, ReflectedStringConvertible {
    
    private(set) public var shape: Shape?
    private(set) public var heelType: HeelType?
    private(set) public var neckline: Neckline?
    private(set) public var closure: ClosureTextSearch?
    private(set) public var size: SizeTextSearch?
    private(set) public var lapelStyle: LapelStyle?
    private(set) public var element: ElementTextSearch?
    private(set) public var dialColor: DialColor?
    private(set) public var bandType: BandType?
    private(set) public var topType: TopType?
    private(set) public var straps: Straps?
    private(set) public var sleeve: Sleeve?
    private(set) public var gender: GenderTextSearch?
    private(set) public var texture: Texture?
    private(set) public var rise: Rise?
    private(set) public var bottomStyle: BottomStyle?
    private(set) public var opening: Opening?
    private(set) public var frameType: FrameType?
    private(set) public var style: StyleTextSearch?
    private(set) public var height: Height?
    private(set) public var look: Look?
    private(set) public var shoesStraps: ShoesStraps?
    private(set) public var topStyle: TopStyle?
    private(set) public var pattern: Pattern?
    private(set) public var trim: Trim?
    private(set) public var color: Color?
    private(set) public var material: Material?
    private(set) public var bottomType: BottomType?
    private(set) public var sleeveStyle: SleeveStyle?
    private(set) public var bandMaterial: BandMaterial?
    private(set) public var hem: Hem?
    private(set) public var type: TypeTextSearch?
    private(set) public var caseShape: CaseShape?
    private(set) public var heelStyle: HeelStyle?
    private(set) public var maxPrice: MaxPrice?
    private(set) public var minPrice: MinPrice?
    private(set) public var length: Length?
    private(set) public var embellishments: Embellishments?
    private(set) public var heelHeight: HeelHeight?
    private(set) public var cat: Cat?
    private(set) public var model: Model?
    private(set) public var detail: Detail?
    
    enum CodingKeys: String, CodingKey {
        case shape = "Shape"
        case heelType = "HeelType"
        case neckline = "Neckline"
        case closure = "Closure"
        case size = "Size"
        case element = "Element"
        case dialColor = "DialColor"
        case bandType = "BandType"
        case topType = "TopType"
        case straps = "Straps"
        case sleeve = "Sleeve"
        case gender = "Gender"
        case texture = "Texture"
        case rise = "Rise"
        case bottomStyle = "BottomStyle"
        case opening = "Opening"
        case frameType = "FrameType"
        case style = "Style"
        case height = "Height"
        case look = "Look"
        case shoesStraps = "ShoesStraps"
        case topStyle = "TopStyle"
        case pattern = "Pattern"
        case trim = "Trim"
        case color = "Color"
        case material = "Material"
        case bottomType = "BottomType"
        case sleeveStyle = "SleeveStyle"
        case bandMaterial = "BandMaterial"
        case hem = "Hem"
        case type = "Type"
        case caseShape = "CaseShape"
        case heelStyle = "HeelStyle"
        case maxPrice = "max_price"
        case minPrice = "min_price"
        case length = "Length"
        case embellishments = "Embellishments"
        case heelHeight = "HeelHeight"
        case cat = "Cat"
        case model = "Model"
        case detail = "Detail"
    }
    
}
