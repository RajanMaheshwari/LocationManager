//
//  ViewController.swift
//  LocationManagerDemo
//
//  Created by Rajan Maheshwari on 22/10/16.
//  Copyright © 2016 Rajan Maheshwari. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Location Manager"
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        } else {
            // Fallback on earlier versions
        }
    }
    
    func resetLabels() {
        latitudeLabel.text = "Latitude"
        longitudeLabel.text = "Longitude"
        addressLabel.text = "Address"
        
    }
    
    func alertMessage(message:String,buttonText:String,completionHandler:(()->())?) {
        let alert = UIAlertController(title: "Location", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonText, style: .default) { (action:UIAlertAction) in
            completionHandler?()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- IBActions

    @IBAction func getCurrentLocationButtonPressed(_ sender: AnyObject) {
        
        self.resetLabels()

        LocationManager.shared.getLocation { (location:CLLocation?, error:NSError?) in
            
            if error != nil {
                self.alertMessage(message: (error?.localizedDescription)!, buttonText: "OK", completionHandler: nil)
                return
            }
            guard let location = location else {
                self.alertMessage(message: "Unable to fetch location", buttonText: "OK", completionHandler: nil)
                return
            }
            self.latitudeLabel.text = "\(location.coordinate.latitude)"
            self.longitudeLabel.text = "\(location.coordinate.longitude)"

        }
    }

    @IBAction func showCurrentLocationOnMap(_ sender: AnyObject) {
        
        self.resetLabels()

        LocationManager.shared.getLocation { (location:CLLocation?, error:NSError?) in
            
            if error != nil {
                self.alertMessage(message: (error?.localizedDescription)!, buttonText: "OK", completionHandler: nil)
                return
            }
            guard let location = location else {
                return
            }
            let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            mapVC.location = location
            self.navigationController?.pushViewController(mapVC, animated: true)
        }
    }
    


    @IBAction func getCurrentAddressButton(_ sender: AnyObject) {
        
        self.resetLabels()
        
        LocationManager.shared.getCurrentReverseGeoCodedLocation { (location:CLLocation?, placemark:CLPlacemark?, error:NSError?) in
            if error != nil {
                self.alertMessage(message: (error?.localizedDescription)!, buttonText: "OK", completionHandler: nil)
                return
            }
            guard let location = location, let placemark = placemark else {
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
            
            self.latitudeLabel.text = "\(location.coordinate.latitude)"
            self.longitudeLabel.text = "\(location.coordinate.longitude)"
        }
    }
    
    @IBAction func locationServiceEnabledAction(_ sender: UIButton) {
        if LocationManager.shared.isLocationEnabled() {
            self.alertMessage(message: "Location Services are enabled", buttonText: "OK", completionHandler: nil)
        } else {
            self.alertMessage(message: "Location Services are disabled", buttonText: "OK", completionHandler: nil)
        }
    }
    
}

