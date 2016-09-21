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
        let urlRequest = "http://" + url + "location_data"
        let locValue:CLLocationCoordinate2D = locations.coordinate
        let formatter = NSDateFormatter()
        formatter.dateFormat = GlobalConstants.dateFormat
        let timestamp: String = formatter.stringFromDate(locations.timestamp)
        let locationData : [String: AnyObject] = [GlobalConstants.latitude: locValue.latitude, GlobalConstants.longitiude: locValue.longitude, GlobalConstants.speed: locations.speed, GlobalConstants.altitude: locations.altitude, GlobalConstants.course: locations.course, GlobalConstants.timestamp: timestamp, GlobalConstants.verticalAccuracy: locations.verticalAccuracy, GlobalConstants.horizontalAccuracy: locations.horizontalAccuracy]
        let postParams : [String: AnyObject] = [GlobalConstants.username: username, GlobalConstants.device_type: "IOS", GlobalConstants.location_data: locationData]
        RequestServer.requestURL(urlRequest, typeOfMethod: "POST", postParams: postParams)
    }
    
}
