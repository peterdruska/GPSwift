//
//  ViewController.swift
//  GPSwift
//
//  Created by Peter Druska on 11.3.2015.
//  Copyright (c) 2015 Become.sk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gpsLocation: GPSwift!
    var now = SwifTime(timeStamp: NSDate())

    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var locatingActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var statusIndicator: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBAction func startLocating(sender: AnyObject) {
        locatingActivityIndicatorView.startAnimating()
        gpsLocation.startLocating()
        statusIndicator.textColor = UIColor(red: 27.0/255.0, green: 165.0/255.0, blue: 0.0, alpha: 1.0)
        self.readTime(NSDate())
    }
    @IBAction func stopLocating(sender: AnyObject) {
        locatingActivityIndicatorView.stopAnimating()
        gpsLocation.stopLocating()
        statusIndicator.textColor = UIColor.lightGrayColor()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "locationHasChanged",
            name: locationChangedNotification,
            object: nil)
        
        gpsLocation = GPSwift.sharedGPS
        self.readTime(NSDate())
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
        print("\(gpsLocation.address.location.coordinate.latitude) \(gpsLocation.address.location.coordinate.longitude)")
        
        self.readTime(NSDate())
        
        locatingActivityIndicatorView.stopAnimating()
    }
    
    func readTime(date: NSDate) {
        now = SwifTime(timeStamp: date)
        now.readTime("d. MMMM y", timeFormat: "H.mm")
        dateLabel.text = now.dateAndTime.date
        timeLabel.text = now.dateAndTime.time
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: locationChangedNotification, object: nil)
    }

}