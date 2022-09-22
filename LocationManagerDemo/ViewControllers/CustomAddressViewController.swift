//
//  CustomAddressViewController.swift
//  LocationManagerDemo
//
//  Created by Rajan Maheshwari on 29/10/16.
//  Copyright © 2016 Rajan Maheshwari. All rights reserved.
//

import UIKit
import CoreLocation

class CustomAddressViewController: UIViewController {

    @IBOutlet weak var addressTextView: UITextView!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func getLatLongButtonPressed(_ sender: Any) {
        if addressTextView.text.count > 0 {
            LocationManager.shared.getReverseGeoCodedLocation(address: addressTextView.text!, completionHandler: { (location:CLLocation?, placemark:CLPlacemark?, error:NSError?) in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let placemark = placemark else {
                    print("Location can't be fetched")
                    return
                }

                self.latitudeLabel.text = "\((placemark.location?.coordinate.latitude)!)"
                self.longitudeLabel.text = "\((placemark.location?.coordinate.longitude)!)"
                
            })
        }
    }

}
