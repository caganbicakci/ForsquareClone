//
//  AddNewPlaceViewController.swift
//  FourSquareClone
//
//  Created by Çağan Bıçakçı on 19.09.2023.
//

import UIKit

class AddNewPlaceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var placeNameField: UITextField!
    @IBOutlet weak var placeTypeField: UITextField!
    @IBOutlet weak var placeAtmosphereField: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    
    let placeModel = PlaceModel.sharedInstance
    let alertManager = AlertManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
        
    }

    @IBAction func nextButtonCliked(_ sender: Any) {
        
        if placeNameField.text != "" && placeTypeField.text != "" && placeAtmosphereField.text != "" {
            placeModel.placeName = placeNameField.text
            placeModel.placeType = placeTypeField.text
            placeModel.placeAtmosphere = placeAtmosphereField.text
            placeModel.placeImage = placeImageView.image
            
            performSegue(withIdentifier: "toMapVC", sender: nil)
            
        }else{
            alertManager.showAlertDialog(context: self, title: "Error", message: "Please fill all the fields!")
        }
        
    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
}
