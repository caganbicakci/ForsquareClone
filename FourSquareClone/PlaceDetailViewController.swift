//
//  PlaceDetailViewController.swift
//  FourSquareClone
//
//  Created by Çağan Bıçakçı on 24.09.2023.
//

import UIKit
import MapKit

class PlaceDetailViewController: UIViewController {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeTypeLabel: UILabel!
    @IBOutlet weak var placeAtmosphereLabel: UILabel!
    @IBOutlet weak var placeMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
