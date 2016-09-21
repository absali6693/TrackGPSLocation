//
//  RequestServer.swift
//  TrackGPSLocation
//
//  Created by GrepRuby1 on 13/09/16.
//  Copyright © 2016 GrepRuby. All rights reserved.
//

import Foundation

class RequestServer: NSObject {
    
    static func requestURL(url: String, typeOfMethod: String, postParams: [String: AnyObject]){
        
        let urlToForward = NSURL(string: url)!
        let session = NSURLSession.sharedSession()
        // Create the request
        let request = NSMutableURLRequest(URL: urlToForward)
        request.HTTPMethod = typeOfMethod
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
