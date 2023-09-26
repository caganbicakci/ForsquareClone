//
//  PlaceModel.swift
//  FourSquareClone
//
//  Created by Çağan Bıçakçı on 24.09.2023.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeId: String?
    var placeName : String?
    var placeType : String?
    var placeAtmosphere : String?
    var placeImage : UIImage?
    var latitude: Double?
    var longitude: Double?
    
    init() {}
}
