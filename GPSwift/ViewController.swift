//
//  ViewController.swift
//  GPSwift
//
//  Created by Peter Druska on 11.3.2015.
//  Copyright (c) 2015 Become.sk. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    var gpsLocation: GPSwift!

    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var locatingActivityIndicatorView: UIActivityIndicatorView!
    @IBAction func startLocating(sender: AnyObject) {
        locatingActivityIndicatorView.startAnimating()
        gpsLocation.startLocating()
    }
    @IBAction func stopLocating(sender: AnyObject) {
        locatingActivityIndicatorView.stopAnimating()
        gpsLocation.stopLocating()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "locationHasChanged",
            name: locationChangedNotification,
            object: nil)
        
        gpsLocation = GPSwift.sharedGPS
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationHasChanged() {
        streetLabel.text = gpsLocation.address.thoroughfare
        numberLabel.text = gpsLocation.address.subThoroughfare
        cityLabel.text = gpsLocation.address.locality
        postalCodeLabel.text = gpsLocation.address.postalCode
        countryLabel.text = gpsLocation.address.ISOcountryCode
        
        locatingActivityIndicatorView.stopAnimating()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: locationChangedNotification, object: nil)
    }

}