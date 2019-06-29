//
//  TablelistViewController.swift
//  OnTheMap
//
//  Created by Deema  on 29/06/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class TablelistViewController: UIViewController {

    @IBOutlet weak var listtable: UITableView!
    var studentList : [StudentInfo]!{
        return StudentInfo.udacityStudent.results
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        API.getLocations { (loaded, error) in
            DispatchQueue.main.async {
                if error != nil {
                    self.showAlert(title: "Erorr performing request", message: "There was an error performing your request")
                    return
                }
                guard let locations = self.studentList else{
                    self.showAlert(title: "Erorr loading locations", message: "There was an error loading locations")
                    return
                }
                self.listtable.reloadData()
                self.listtable.endUpdates()
            }
        }
    }
    
    @IBAction func addLocation(_ sender: Any) {
        let addLocationVC = self.storyboard!.instantiateViewController(withIdentifier: "AddLocationViewController") as! AddLocationViewController
        navigationController!.pushViewController(addLocationVC, animated: true)
    }
    
    @IBAction func refreshLocations(_ sender: Any) {
        API.getLocations { (loaded, error) in
            DispatchQueue.main.async {
                if error != nil {
                    self.showAlert(title: "Erorr performing request", message: "There was an error performing your request")
                    return
                }
                guard let locations = self.studentList else{
                    self.showAlert(title: "Erorr loading locations", message: "There was an error loading locations")
                    return
                }
                self.listtable.reloadData()
                self.listtable.endUpdates()
            }
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        API.logOutAPI { (error) in
            DispatchQueue.main.async {
                if error != nil {
                    self.showAlert(title: "Error", message: "try again please")
                }
                else{
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
    }
    

}
