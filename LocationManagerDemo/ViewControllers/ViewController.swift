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
        self.title = "Location Manager"
        self.setupNav()
    }
    
    // MARK: - Private Methods
    private func setupNav() {
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
    
    private func resetLabels() {
        self.latitudeLabel.text = "Latitude"
        self.longitudeLabel.text = "Longitude"
        self.addressLabel.text = "Address"
    }
    
    private func goToMapScreen(location: CLLocation) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        vc.location = location
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: -  IBActions
    
    @IBAction func getCurrentLocationButtonPressed(_ sender: AnyObject) {
        
        self.resetLabels()

        LocationManager.shared.getLocation { [weak self] location, error in
            
            if let error = error {
                self?.alertMessage(message: error.localizedDescription, buttonText: "OK", completionHandler: nil)
                return
            }

            guard let location = location else {
                self?.alertMessage(message: "Unable to fetch location", buttonText: "OK", completionHandler: nil)
                return
            }
            self?.latitudeLabel.text = "Latitude: \(location.coordinate.latitude)"
            self?.longitudeLabel.text = "Longitude: \(location.coordinate.longitude)"
        }
    }

    @IBAction func showCurrentLocationOnMap(_ sender: AnyObject) {
        
        self.resetLabels()

        LocationManager.shared.getLocation { [weak self] location, error in
            
            if let error = error {
                self?.alertMessage(message: error.localizedDescription, buttonText: "OK", completionHandler: nil)
                return
            }
            
            guard let location = location else {
                return
            }
            self?.goToMapScreen(location: location)
        }
    }
    


    @IBAction func getCurrentAddressButton(_ sender: AnyObject) {
        
        self.resetLabels()
        
        LocationManager.shared.getCurrentReverseGeoCodedLocation { [weak self] location, placemark, error in
            
            if let error = error {
                self?.alertMessage(message: error.localizedDescription, buttonText: "OK", completionHandler: nil)
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

            self?.addressLabel.text = "The address fetched is: \n\n" + placemark.description
            
            self?.latitudeLabel.text = "Latitude: \(location.coordinate.latitude)"
            self?.longitudeLabel.text = "Longitude: \(location.coordinate.longitude)"
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
