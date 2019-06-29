//
//  ExtentionVC.swift
//  OnTheMap
//
//  Created by Deema  on 29/05/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit


extension UIViewController : UITextFieldDelegate {
    private func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}
    
    extension UIViewController{
        func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        func showActivityIndicator() -> UIActivityIndicatorView {
            let activityIndicator = UIActivityIndicatorView(style: .white)
            self.view.addSubview(activityIndicator)
            self.view.bringSubviewToFront(activityIndicator)
            activityIndicator.hidesWhenStopped = true
            activityIndicator.center = self.view.center
            activityIndicator.startAnimating()
            return activityIndicator
        }
    }
    
    



