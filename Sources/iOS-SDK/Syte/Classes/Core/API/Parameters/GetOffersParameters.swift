//
//  GetOffersswift
//  Syte
//
//  Created by Artur Tarasenko on 17.09.2021.
//

import Foundation

struct GetOffersParameters {
    
    let offersUrl: String
    let crop: String?
    let forceCats: String?
    
    func dictionaryRepresentation() -> [String: Any] {
        let parameters = ["crop": crop, "force_cats": forceCats].compactMapValues({$0})
        return parameters
    }
    
}
