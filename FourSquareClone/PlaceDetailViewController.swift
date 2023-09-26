//
//  PlaceDetailViewController.swift
//  FourSquareClone
//
//  Created by Çağan Bıçakçı on 24.09.2023.
//

import UIKit
import MapKit
import Parse

class PlaceDetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeTypeLabel: UILabel!
    @IBOutlet weak var placeAtmosphereLabel: UILabel!
    @IBOutlet weak var placeMapView: MKMapView!
    
    var placeLatitude : Double?
    var placeLongitude : Double?
    
    let alertManager = AlertManager()
    
    var chosenPlaceId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromParse()
        placeMapView.delegate = self
        
    }
    
    func getDataFromParse(){
        let query = PFQuery(className: "Places")
        
        query.whereKey("objectId", equalTo: chosenPlaceId!)
        query.findObjectsInBackground { objects, error in
            if error != nil {
                self.alertManager.showAlertDialog(context: self, title: "Error", message: error?.localizedDescription)
            }else {
                if objects != nil {
                    
                    let pfResult = objects![0]
                    
                    if let placeName = pfResult.object(forKey: "name") as? String,
                       let placeType = pfResult.object(forKey: "type") as? String,
                       let placeAtmosphere = pfResult.object(forKey: "atmosphere") as? String {
                        self.placeNameLabel.text = placeName
                        self.placeTypeLabel.text = placeType
                        self.placeAtmosphereLabel.text = placeAtmosphere
                    }

                    if let imageData = pfResult.object(forKey: "image") as? PFFileObject {
                        imageData.getDataInBackground { data, error in
                            if error == nil {
                                self.placeImageView.image = UIImage(data: data!)
                            }
                        }
                    }
                    
                    if let placeLatitude = pfResult.object(forKey: "latitude") as? Double,
                       let placeLongitude = pfResult.object(forKey: "longitude") as? Double {
                        
                        self.placeLatitude = placeLatitude
                        self.placeLongitude = placeLongitude
                                                
                        let location = CLLocationCoordinate2D(latitude: placeLatitude, longitude: placeLongitude)
                        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        let region = MKCoordinateRegion(center: location, span: span)
                        self.placeMapView.setRegion(region, animated: true)
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location
                        
                        annotation.title = self.placeNameLabel.text
                        annotation.subtitle = self.placeTypeLabel.text
                        
                        self.placeMapView.addAnnotation(annotation)
                        
                    }
                    
                }
            }
        }
    }
    

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseID = "pinViewID"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if self.placeLatitude != nil && self.placeLongitude != nil {
            let requestLocation = CLLocation(latitude: self.placeLatitude!, longitude: self.placeLongitude!)

            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
                if error != nil {
                    self.alertManager.showAlertDialog(context: self, title: "Error", message: error?.localizedDescription)
                }else {
                    if let placemark = placemarks {
                        if  placemark.count > 0 {
                            let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                            let mapItem = MKMapItem(placemark: mkPlaceMark)
                            mapItem.name = self.placeNameLabel.text
                            
                            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                            
                            mapItem.openInMaps(launchOptions: launchOptions)
                        }
                    }
                }
            }
        }
        
    }
    
}
