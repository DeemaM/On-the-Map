//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Deema  on 23/06/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController ,MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
   
    var students: [StudentInfo]! {
        return StudentInfo.udacityStudent.results
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gLocations()
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        API.logOutAPI { (error) in
            DispatchQueue.main.async {
                if error != nil {
                    self.showAlert(title: "can't log out", message: "try again please")
                }
                else{
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func Refresh(_ sender: Any) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        gLocations()
    }
    
    
    @IBAction func addLocations(_ sender: Any) {
        let addLocationVC = self.storyboard!.instantiateViewController(withIdentifier: "AddLocationViewController") as! AddLocationViewController
        navigationController!.pushViewController(addLocationVC, animated: true)
    }
    
    
    
    
    func gLocations(){
        API.getLocations { (loaded, error) in
            DispatchQueue.main.async {
                if error != nil {
                    self.showAlert(title: "Erorr performing request", message: "There was an error performing your request")
                    return
                }
                guard let locations = self.students else{
                    self.showAlert(title: "Erorr loading locations", message: "There was an error loading locations")
                    return
                }
                var annotations = [MKPointAnnotation] ()
                for location in self.students {
                    let long = CLLocationDegrees (location.longitude ?? 0)
                    let lat = CLLocationDegrees (location.latitude ?? 0)
                    
                    let coords = CLLocationCoordinate2D (latitude: lat, longitude: long)
                    let first = location.firstName ?? " "
                    let last = location.lastName ?? " "
                    let mediaURL = location.mediaURL ?? " "
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coords
                    annotation.title = "\(first) \(last)"
                    annotation.subtitle = mediaURL
                    
                    annotations.append (annotation)
                }
                self.mapView.addAnnotations (annotations)
            }
        }
    }
    


}
