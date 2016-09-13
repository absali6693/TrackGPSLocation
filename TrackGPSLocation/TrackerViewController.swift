//
//  ViewController.swift
//  TrackGPSLocation
//
//  Created by GrepRuby1 on 13/09/16.
//  Copyright © 2016 GrepRuby. All rights reserved.
//

import UIKit
import CoreLocation

class TrackerViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak private var usernameTestField: UITextField!
    @IBOutlet weak private var urlTestField: UITextField!
    @IBOutlet weak private var frequencyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate =  self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - IBAction

extension TrackerViewController {
    @IBAction func sendButtonClicked(sender: AnyObject) {
        //might need to change
        NSTimer.scheduledTimerWithTimeInterval(Double(self.frequencyTextField.text!) ?? 2.0, target: self, selector: #selector(TrackerViewController.callInTime), userInfo: nil, repeats: true)

    }
    
}

//MARK:- Call to server file method

extension TrackerViewController {
    func callInTime() {
        self.locationManager.startUpdatingLocation()
    }
    
    func sendData(locations: CLLocation) {
        
        let sendDataToServer = SendDataToServer()
        sendDataToServer.sendData(self.usernameTestField.text!, url:self.urlTestField.text!, locations: locations)
    }
    
}


//MARK:- Delegate for location manager

extension TrackerViewController {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let locValue = manager.location
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil)
            {
                print("Error: " + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0
            {
                self.locationManager.stopUpdatingLocation()
                self.sendData(locValue!)
            }
            else
            {
                print("Error with the data.")
            }
        })
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error: " + error.localizedDescription)
    }
    
    
}
