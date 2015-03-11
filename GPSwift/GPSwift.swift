//
//  GPSwift.swift
//  GPSwift
//
//  Created by Peter Druska on 11.3.2015.
//  Copyright (c) 2015 Become.sk. All rights reserved.
//

import Foundation
import CoreLocation

var locationChangedNotification = "locationHasChangedNotification"

struct Address {
    var thoroughfare = String()
    var subThoroughfare = String()
    var locality = String()
    var postalCode = String()
    var ISOcountryCode = String()
}

class GPSwift: NSObject, CLLocationManagerDelegate {
    
    var location = CLLocation()
    var locationManager = CLLocationManager()
    var address = Address()
    
    override init () {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    class var sharedGPS: GPSwift {
        struct Static {
            static var instance: GPSwift?
            static var token: dispatch_once_t = 0
        }

        dispatch_once(&Static.token) {
            Static.instance = GPSwift()
        }
        
        return Static.instance!
    }
    
    func startLocating() {
        println("start locating")
        locationManager.startUpdatingLocation()
    }
    
    func stopLocating() {
        println("stop locating")
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        location = locations.last as CLLocation
        self.locationAddress(location)
    }
    
    func locationAddress(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                self.address.thoroughfare = pm.thoroughfare ?? "—"
                self.address.subThoroughfare = pm.subThoroughfare ?? "—"
                self.address.locality = pm.locality ?? "—"
                self.address.postalCode = pm.postalCode ?? "—"
                self.address.ISOcountryCode = pm.ISOcountryCode ?? "—"
                NSNotificationCenter.defaultCenter().postNotificationName(locationChangedNotification, object: nil)
            }
            else {
                println("Problem with the data received from geocoder")
            }
        })
    }
}