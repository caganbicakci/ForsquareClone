//
//  SignupViewController.swift
//  FourSquareClone
//
//  Created by Çağan Bıçakçı on 18.09.2023.
//

import UIKit
import Parse

class SignupViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var birthdatePicker: UIDatePicker!
    
    let alertManger = AlertManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupButtonClicked(_ sender: Any) {
        
        if usernameField.text != "" && passwordField.text != "" &&
            usernameField.text != "" {
            createUser(email: emailField.text!, password: passwordField.text!, username: usernameField.text!, city: cityField.text, brithDate: birthdatePicker.date)
        }else{
            self.alertManger.showAlertDialog(context: self, title: "Error!", message: "Please check the given informations!")
        }
    }
    
    func createUser(email: String, password: String, username: String, city: String?, brithDate: Date?){
        let user = PFUser()
        user.email = email
        user.password = password
        user.username = username
        
        user.signUpInBackground {(success, error) in
            if error != nil {
                self.alertManger.showAlertDialog(context: self, title: "Error!", message: error?.localizedDescription ?? "Someting went wrong.")
            }else {
                self.performSegue(withIdentifier: "fromSignupToPlacesVC", sender: nil)
            }
        }
        
    }
}
