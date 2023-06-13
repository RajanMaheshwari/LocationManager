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
        if !addressTextView.text.isEmpty {
            LocationManager.shared.getReverseGeoCodedLocation(address: addressTextView.text!, completionHandler: { [weak self] location, placemark, error in
                
                if let error {
                    self?.alertMessage(message: error.localizedDescription, buttonText: "Ok", completionHandler: nil)
                    return
                }
                
                guard let placemark else {
                    self?.alertMessage(message: "Location can't be fetched", buttonText: "Ok", completionHandler: nil)
                    return
                }

                self?.latitudeLabel.text = "Latitude: \((placemark.location?.coordinate.latitude)!)"
                self?.longitudeLabel.text = "Longitude: \((placemark.location?.coordinate.longitude)!)"
                
            })
        }
    }

}
