# GPSwift

GPSwift allows you to simple connect to CoreLocation framework and returns address in human readable format.

## GPSwift.swift

File creates singleton class to provide geo location update data in human readable structure.

## Install

In viewController just create variables of `CLLocationManager` and `GPSwift`:

``` swift
var locationManager = CLLocationManager()
var gpsLocation: GPSwift!
```

Create singleton instance:

``` swift
gpsLocation = GPSwift.sharedGPS
```

Then just simple start locating:

``` swift
gpsLocation.startLocating()
```

or stop locating:

``` swift
gpsLocation.stopLocating()
```

After succesfull location update GPSwift singleton post observer named `locationChangedNotification`. So add observer to viewController like this:

``` swift
NSNotificationCenter.defaultCenter().addObserver(
    self,
    selector: "locationHasChanged",
    name: locationChangedNotification,
    object: nil)
```

Then use function `locationHasChanged` to read geo located address:

``` swift
func locationHasChanged() {
    println("\(gpsLocation.address.thoroughfare)")
    println("\(gpsLocation.address.subThoroughfare)")
    println("\(gpsLocation.address.locality)")
    println("\(gpsLocation.address.postalCode)")
    println("\(gpsLocation.address.ISOcountryCode)")
}
```

## Screens

![Preview](/GPSwift_1.png)

![Preview](/GPSwift_2.png)

And that's it.

Happy geo locating.