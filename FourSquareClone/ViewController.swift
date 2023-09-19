//
//  ViewController.swift
//  FourSquareClone
//
//  Created by Çağan Bıçakçı on 17.09.2023.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    let alertManager = AlertManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        if usernameField.text != "" && passwordField.text != "" {
            
            PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { user, error in
                
                if error != nil {
                    self.alertManager.showAlertDialog(context: self, title: "Error!", message: error?.localizedDescription)
                }else {
                    self.performSegue(withIdentifier: "fromLoginToPlacesVC", sender: nil)
                }
            }
            
        }else {
            alertManager.showAlertDialog(context: self, title: "Error!", message: "Please check email and password!")
        }
    }
}

