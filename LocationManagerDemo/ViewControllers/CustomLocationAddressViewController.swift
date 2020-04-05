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

    @IBOutlet weak var longitudeTextField: UITextField!
    
    @IBOutlet weak var latitudeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        addressLabel.text = "Address"

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func alertMessage(message:String,buttonText:String,completionHandler:(()->())?) {
        let alert = UIAlertController(title: "Location", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonText, style: .default) { (action:UIAlertAction) in
            completionHandler?()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func getAddressButton(_ sender: AnyObject) {
        
        self.view.endEditing(true)
        addressLabel.text = "Address"
        let lat  = Double(latitudeTextField.text!)
        let long = Double(longitudeTextField.text!)
        if let _ = lat, let _ = long {
            let customLocation = CLLocation(latitude: lat!, longitude: long!)
            
            LocationManager.shared.getReverseGeoCodedLocation(location: customLocation) { (location:CLLocation?, placemark:CLPlacemark?, error:NSError?) in
                if error != nil {
                    self.alertMessage(message: (error?.localizedDescription)!, buttonText: "OK", completionHandler: nil)
                    return
                }
                guard let _ = location, let placemark = placemark else {
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
                print(placemark.addressDictionary?.description ?? "")
                
                let address = placemark.addressDictionary?["FormattedAddressLines"] as! NSArray
                self.addressLabel.text = address.description
                
            }
        } else {
            self.alertMessage(message: "Lat/Long can't be empty", buttonText: "OK", completionHandler: { 
                self.latitudeTextField.becomeFirstResponder()
            })
        }
        
    }

}
