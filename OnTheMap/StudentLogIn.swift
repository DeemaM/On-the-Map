//
//  StudentLogIn.swift
//  OnTheMap
//
//  Created by Deema  on 26/05/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class StudentLogIn: UIViewController {
    @IBOutlet weak var inputEmail: UITextField!
    
    @IBOutlet weak var inputPassword: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func logIn(_ sender: Any) {
        let activityIndicator = showActivityIndicator()
        if (inputEmail.text?.isEmpty)! || (inputPassword.text?.isEmpty)! {
            showAlert(title: "Can't log in", message: "Missing email or password")
            activityIndicator.stopAnimating()
        }
        else{
            API.login(username: inputEmail.text! , password: inputPassword.text!) { (key, error) in
                DispatchQueue.main.sync{
                    activityIndicator.stopAnimating()
                    if (error != nil){
                        self.showAlert(title: "Error connecting", message: "Please try again")
                    }
                    else if (error == nil && key == ""){
                        self.showAlert(title: "incorrect email or password", message: "Please try again")
                    }
                    else if key == "No response"{
                        self.showAlert(title: "Can't get a response", message: "Please try again")
                    }
                    else{//(key != "" )
                        StudentInfo.userKey = key
                        self.performSegue(withIdentifier: "tabBar", sender: self)
                    }
                }
            }
        }
    
    }
    
    @IBAction func signUp(_ sender: Any) {
        if let URL = URL(string: "https://auth.udacity.com/sign-up"){
            UIApplication.shared.open(URL, options: [:], completionHandler: nil)
        }
        else {
            self.showAlert(title: "Sorry!", message: "sign up page unreachable or incorrect")
        }
    }
    


}


