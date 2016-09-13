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
        let postEndpoint = url
        let formatter = NSDateFormatter()
        formatter.dateFormat = GlobalConstants.dateFormat
        let timestamp: String = formatter.stringFromDate(locations.timestamp)
        let url = NSURL(string: postEndpoint)!
        let session = NSURLSession.sharedSession()
        let locationData : [String: AnyObject] = [GlobalConstants.latitude: locValue.latitude, GlobalConstants.longitiude: locValue.longitude, GlobalConstants.speed: locations.speed, GlobalConstants.altitude: locations.altitude, GlobalConstants.course: locations.course, GlobalConstants.timestamp: timestamp]
        let postParams : [String: AnyObject] = [GlobalConstants.username: username, "device_type": "IOS", "location_data": locationData]
        // Create the request
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(postParams, options: NSJSONWritingOptions())
            print(postParams)
        } catch {
            print("Error")
        }
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithRequest(request, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            // Read the JSON
            if let postString = NSString(data:data!, encoding: NSUTF8StringEncoding) as? String {
                // Print what we got from the call
                print("POST: " + postString)
            }
            
        }).resume()
    }
}
