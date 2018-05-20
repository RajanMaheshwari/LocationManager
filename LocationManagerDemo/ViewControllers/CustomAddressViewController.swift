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
            LocationManager.sharedInstance.getReverseGeoCodedLocation(address: addressTextView.text!, completionHandler: { (location:CLLocation?, placemark:CLPlacemark?, error:NSError?) in
                
                if error != nil {
                    print((error?.localizedDescription)!)
                    return
                }
                
                if placemark == nil {
                    print("Location can't be fetched")
                    return
                }
                
                print(placemark?.addressDictionary?.description ?? "")

                self.latitudeLabel.text = "\((placemark?.location?.coordinate.latitude)!)"
                self.longitudeLabel.text = "\((placemark?.location?.coordinate.longitude)!)"
                
            })
        }
    }

}
