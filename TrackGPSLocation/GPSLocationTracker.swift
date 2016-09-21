//
//  GPSLocationTracker.swift
//  TrackGPSLocation
//
//  Created by GrepRuby1 on 14/09/16.
//  Copyright © 2016 GrepRuby. All rights reserved.
//

import Foundation
import CoreLocation

protocol DetailViewControllerDelegate: class {
    func didFinishTask(locations: CLLocation)
}

class GPSLocationTracker: NSObject,CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    weak var delegate:DetailViewControllerDelegate?
    
    override init() {
        super.init()
        self.locationManager.delegate =  self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
  
    func track() {
        self.locationManager.startUpdatingLocation()
    }
    
    func sendData(locations: CLLocation) {
        delegate?.didFinishTask(locations)
    }
}

//MARK: - GPS Delegate Functions

extension GPSLocationTracker {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let locValue = manager.location
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                print("Error: " + error!.localizedDescription)
                return
            }
            if placemarks!.count > 0 {
                self.locationManager.stopUpdatingLocation()
                self.sendData(locValue!)
            }
            else {
                print("Error with the data.")
            }
        })
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
}
