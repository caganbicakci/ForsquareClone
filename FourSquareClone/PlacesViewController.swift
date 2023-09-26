//
//  PlacesViewController.swift
//  FourSquareClone
//
//  Created by Çağan Bıçakçı on 19.09.2023.
//

import UIKit
import Parse

class PlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var placesTableView: UITableView!
    let alertManager = AlertManager()
    var placeArray = [PlaceModel]()
    var selectedPlaceId : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logOutButtonClicked))
        
        placesTableView.delegate = self
        placesTableView.dataSource = self
        
        getDataFromParse()
    }
    
    func getDataFromParse(){
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.alertManager.showAlertDialog(context: self, title: "Error", message: error?.localizedDescription)
            }else{
                
                if objects != nil {
                    
                    self.placeArray.removeAll(keepingCapacity: false)
                    
                    for result in objects! {
                        if let placeId = result.objectId,
                           let placeName = result.object(forKey: "name") as? String {
                           
                           let place = PlaceModel()
                           place.placeId = placeId
                           place.placeName = placeName
                           
                           self.placeArray.append(place)
                           
                       }
                    }
                    self.placesTableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlaceDetailVC" {
            let destinationVC = segue.destination as! PlaceDetailViewController
            destinationVC.chosenPlaceId = selectedPlaceId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceId = placeArray[indexPath.row].placeId
        self.performSegue(withIdentifier: "toPlaceDetailVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        placeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeArray[indexPath.row].placeName
        return cell
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
