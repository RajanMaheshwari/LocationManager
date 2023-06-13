//
//  CustomLocationAddressViewController.swift
//  LocationManagerDemo
//
//  Created by Rajan Maheshwari on 22/10/16.
//  Copyright © 2016 Rajan Maheshwari. All rights reserved.
//

import UIKit
import CoreLocation

class CustomLocationAddressViewController: UIViewController {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var longitudeTextField: TextFieldWithPadding!
    @IBOutlet weak var latitudeTextField: TextFieldWithPadding!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addressLabel.text = "Address"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func getAddressButton(_ sender: AnyObject) {
        
        self.view.endEditing(true)
        addressLabel.text = "Address"
        let latitude  = Double(latitudeTextField.text!)
        let longtitude = Double(longitudeTextField.text!)
        if let latitude, let longtitude {
            let customLocation = CLLocation(latitude: latitude, longitude: longtitude)
            
            LocationManager.shared.getReverseGeoCodedLocation(location: customLocation) { [weak self] location, placemark, error in
                if let error {
                    self?.alertMessage(message: error.localizedDescription, buttonText: "OK", completionHandler: nil)
                    return
                }
                guard let _ = location,
                      let placemark  else {
                    return
                }
                print(placemark.administrativeArea ?? "")
                print(placemark.name ?? "")
                print(placemark.country ?? "")
                print(placemark.areasOfInterest ?? "")
                print(placemark.isoCountryCode ?? "")
                print(placemark.location ?? "")
                print(placemark.locality ?? "")
                print(placemark.subLocality ?? "")
                print(placemark.postalCode ?? "")
                print(placemark.timeZone ?? "")
                
                self?.addressLabel.text = "The address fetched is:\n\n" + placemark.description

            }
        } else {
            self.alertMessage(message: "Lat/Long can't be empty", buttonText: "OK", completionHandler: {
                self.latitudeTextField.becomeFirstResponder()
            })
        }
        
    }
}

class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 0,
        left: 20,
        bottom: 0,
        right: 20
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
