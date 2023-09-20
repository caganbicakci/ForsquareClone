//
//  AddNewPlaceViewController.swift
//  FourSquareClone
//
//  Created by Çağan Bıçakçı on 19.09.2023.
//

import UIKit

class AddNewPlaceViewController: UIViewController {

    @IBOutlet weak var placeNameField: UITextField!
    @IBOutlet weak var placeTypeField: UITextField!
    @IBOutlet weak var placeAtmosphereField: UITextField!
    @IBOutlet weak var selectImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func nextButtonCliked(_ sender: Any) {
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
}
