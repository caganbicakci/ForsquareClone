//
//  PlacesViewController.swift
//  FourSquareClone
//
//  Created by Çağan Bıçakçı on 19.09.2023.
//

import UIKit
import Parse

class PlacesViewController: UIViewController {

    @IBOutlet weak var placesTableView: UITableView!
    let alertManager = AlertManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logOutButtonClicked))
    }
    
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "toAddNewPlaceVC", sender: nil)
    }
    
    @objc func logOutButtonClicked(){
        PFUser.logOutInBackground { [self] (error) in
            if error != nil {
                alertManager.showAlertDialog(context: self, title: "Error", message: error?.localizedDescription)
            }else{
                performSegue(withIdentifier: "toLoginVC", sender: nil)
            }
        }
    }
}
