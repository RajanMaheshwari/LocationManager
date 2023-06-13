//
//  UIViewController+Addition.swift
//  LocationManagerDemo
//
//  Created by Rajan Maheshwari on 14/06/23.
//  Copyright © 2023 Rajan Maheshwari. All rights reserved.
//

import UIKit

extension ViewController {
    
    func alertMessage(message:String, buttonText:String, completionHandler: (()->())?) {
        let alert = UIAlertController(title: "Location", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonText, style: .default) { (action:UIAlertAction) in
            completionHandler?()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
