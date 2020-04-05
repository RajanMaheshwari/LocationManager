# LocationManager
Location Manager is a library written in Swift 5.0 for iOS which handles the location features provided by Apple. It is fairly simple to use where you can just get your current location, current address, custom location and custom address by just a single method call.

#Requirements

iOS 10.0+<br>
Xcode 11.0+<br>
Swift 5.0+

How to use it.<br>
Just add ```LocationManager.swift``` into your project

In order to just get your current Latitude and Longitude

```swift
LocationManager.shared.getLocation { (location:CLLocation?, error:NSError?) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            guard let location = location else {
                return
            }
            print("Latitude: \(location.coordinate.latitude) Longitude: \(location.coordinate.longitude)")
        }
```

For getting the current address we can call the ```getCurrentReverseGeoCodedLocation``` method

```swift
LocationManager.shared.getCurrentReverseGeoCodedLocation { (location:CLLocation?, placemark:CLPlacemark?, error:NSError?) in
            
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            guard let location = location, let placemark = placemark else {
                return
            }
            //We get the complete placemark and can fetch anything from CLPlacemark
            print(placemark.addressDictionary?.description)
        }
```
<h2>For Swift 3.0.1+ versions</h2>

Nil-Coalescing Operator is mandatory if you are printing an optional value without unwrapping it else it will give you warning.

```swift         
print(placemark.addressDictionary?.description ?? "")
```


You can also reverse geocode any address just by providing latitude and longitude in a CLLocation object coming from Google/ Apple or by your API.

```swift
let customLocation = CLLocation(latitude: 22.76456, longitude: 77.42323)
        
LocationManager.shared.getReverseGeoCodedLocation(location: customLocation) { (location:CLLocation?, placemark:CLPlacemark?, error:NSError?) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            guard let location = location, let placemark = placemark else {
                return
            }
            //We get the complete placemark and can fetch anything from CLPlacemark
            print(placemark.addressDictionary?.description)
        }
```

From Swift 3.0.1, Nil-Coalescing Operator is mandatory if you are printing an optional value without unwrapping it else it will give you warning.

```swift         
print(placemark.addressDictionary?.description ?? "")
```

You can now get the Latitude and Longitude of an address entered as a string

```swift
LocationManager.shared.getReverseGeoCodedLocation(address: yourAddress, completionHandler: { (location:CLLocation?, placemark:CLPlacemark?, error:NSError?) in
                
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
                
            guard let _ = location, let placemark = placemark else {
                return
            }
               
            print(placemark.addressDictionary?.description ?? "")
            print((placemark.location?.coordinate.latitude)!)
            print((placemark.location?.coordinate.longitude)!)
                
        })
```

Now you can check whether the location services are enabled or not using

```LocationManager.shared.isLocationEnabled()```

It returns a Bool, true if services are enabled, false if they are disabled.

CocoaPods and Carthage support coming soon!!
