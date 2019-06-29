//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Deema  on 27/06/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit
import MapKit
class AddLocationViewController: UIViewController {

    @IBOutlet weak var locationspace: UITextField!
    @IBOutlet weak var Linkspace: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func FindLocation(_ sender: Any) {
        if locationspace.text == "" {
            showAlert(title: "Location missing", message: "Please enter your location")
        }
        else if Linkspace.text == "" {
            showAlert(title: "Link missing", message: "Please enter your link ")
        }
        else {
            let activityIndicator = showActivityIndicator()
            var userLocation = StudentInfo(mapString: locationspace.text!,  mediaURL: Linkspace.text!, uniqueKey: StudentInfo.userKey)
            CLGeocoder().geocodeAddressString(userLocation.mapString!) { (placeMark, error) in
                activityIndicator.stopAnimating()
                guard let firstUserLocation = placeMark?.first?.location else {
                    self.showAlert(title: "can't find location ", message: "Please enter a real location")
                    return
                }
                
                userLocation.latitude = firstUserLocation.coordinate.latitude
                userLocation.longitude = firstUserLocation.coordinate.longitude
                
                
                let newLocationVC = self.storyboard!.instantiateViewController(withIdentifier: "ConfirmNewLocationViewController") as! ConfirmNewLocationViewController
                newLocationVC.userInfo = userLocation
                self.navigationController!.pushViewController(newLocationVC , animated: true)        }
    }
    
    

}
}


extension StudentInfo {
    init(mapString: String?, mediaURL: String?, uniqueKey: String?) {
        self.mapString = mapString
        self.mediaURL = mediaURL
        self.uniqueKey = uniqueKey
        self.createdAt = nil
        self.firstName = nil
        self.lastName = nil
        self.latitude = nil
        self.longitude = nil
        self.objectId = nil
        self.updatedAt = nil
    }}
