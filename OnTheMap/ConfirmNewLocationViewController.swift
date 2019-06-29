//
//  ConfirmNewLocationViewController.swift
//  OnTheMap
//
//  Created by Deema  on 27/06/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit
import MapKit
class ConfirmNewLocationViewController: UIViewController {
    var userInfo : StudentInfo?

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        confirmButton.isEnabled = false
        
        guard let userInfo = userInfo else{
            self.showAlert(title: "Erorr getting the locations", message: "There was an error getting the locations")
            return
        }
        let long = CLLocationDegrees (userInfo.longitude ?? 0)
        let lat = CLLocationDegrees (userInfo.latitude ?? 0)
        
        let coords = CLLocationCoordinate2D (latitude: lat, longitude: long)
        let first = userInfo.firstName ?? " "
        let last = userInfo.lastName ?? " "
        let mediaURL = userInfo.mediaURL ?? " "
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coords
        annotation.title = "\(first) \(last)"
        annotation.subtitle = mediaURL
        confirmButton.isEnabled = true
        self.mapView.addAnnotation(annotation)
    }
    
    
    @IBAction func confirm(_ sender: Any) {
        API.postLocation(mapString: (userInfo?.mapString)! , mediaURL: (userInfo?.mediaURL)!, latitude: (userInfo?.latitude)!, longitude: (userInfo?.longitude)!){ (error) in
            DispatchQueue.main.sync {
                if error != nil {
                    self.showAlert(title: "Error", message: "try again")
                }else{
                    self.navigationController!.popToRootViewController(animated: true)
                }
            }
        }
    }
    

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin" ) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
}
