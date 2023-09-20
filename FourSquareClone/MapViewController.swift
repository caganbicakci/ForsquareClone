//
//  MapViewController.swift
//  FourSquareClone
//
//  Created by Çağan Bıçakçı on 20.09.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonClicked))
    }
    
    @objc func saveButtonClicked(){
        // TODO: Parse Save
    }
}
