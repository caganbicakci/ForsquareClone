//
//  MapViewController.swift
//  FourSquareClone
//
//  Created by Çağan Bıçakçı on 20.09.2023.
//

import UIKit
import MapKit
import Parse

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let alertManager = AlertManager()
    
    let locationManager = CLLocationManager()
    let placeModel = PlaceModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonClicked))
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(selectLocation(gestureRecognizer:)))
        recognizer.minimumPressDuration = 1
        mapView.addGestureRecognizer(recognizer)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    @objc func saveButtonClicked(){
        let placeModel = PlaceModel.sharedInstance
        let object = PFObject(className: "Places")
        object["name"] = placeModel.placeName
        object["type"] = placeModel.placeType
        object["atmosphere"] = placeModel.placeAtmosphere
        object["latitude"] = placeModel.latitude
        object["longitude"] = placeModel.longitude
        
        if let imageData = placeModel.placeImage?.jpegData(compressionQuality: 0.5){
            object["image"] = PFFileObject(name: "image.jpg", data: imageData)
            
        }
        
        object.saveInBackground { success, error in
            if error != nil {
                self.alertManager.showAlertDialog(context: self, title: "Error", message: error?.localizedDescription)
            }else{
                self.performSegue(withIdentifier: "fromMapVCtoPlacesVC", sender: nil)
            }
        }
    }
    
    @objc func selectLocation(gestureRecognizer: UIGestureRecognizer){
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began{
            let touches = gestureRecognizer.location(in: self.mapView)
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            
            self.mapView.addAnnotation(annotation)
            self.placeModel.latitude = coordinates.latitude
            self.placeModel.longitude = coordinates.longitude
            
        }
    }
}
