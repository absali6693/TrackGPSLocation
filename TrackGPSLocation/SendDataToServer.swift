//
//  SendDataToServer.swift
//  TrackGPSLocation
//
//  Created by GrepRuby1 on 13/09/16.
//  Copyright © 2016 GrepRuby. All rights reserved.
//

import Foundation
import CoreLocation

class SendDataToServer: NSObject{

    
    func sendData(username: String, url: String,locations: CLLocation) {
        let locValue:CLLocationCoordinate2D = locations.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        print(locations.speed)
        print(locations.altitude)
        print(locations.course)
        print(locations.timestamp)

        
    }
}

//MARK:- Delegate for location manager

extension SendDataToServer {
    
   
    
}