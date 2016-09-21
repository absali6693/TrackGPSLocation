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
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak private var usernameTestField: UITextField!
    @IBOutlet weak private var urlTestField: UITextField!
    @IBOutlet weak private var frequencyTextField: UITextField!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TrackerViewController {
    func setFields() {
        let stringKey = NSUserDefaults.standardUserDefaults()
        usernameTestField.text = stringKey.stringForKey(GlobalConstants.username)
        urlTestField.text = stringKey.stringForKey(GlobalConstants.url)
        frequencyTextField.text =  stringKey.stringForKey(GlobalConstants.frequency)
    }
}

//MARK: - IBActions

extension TrackerViewController {
    @IBAction func sendButtonClicked(sender: AnyObject) {
        let nSUserDefault = NSUserDefaults.standardUserDefaults()
        nSUserDefault.setObject(usernameTestField.text, forKey: GlobalConstants.username)
        nSUserDefault.setObject(urlTestField.text, forKey: GlobalConstants.url)
        nSUserDefault.setObject(frequencyTextField.text, forKey: GlobalConstants.frequency)
        nSUserDefault.synchronize()
    }
}

//MARK: - SEGUE

extension TrackerViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == GlobalConstants.toMapSegue {
            let mapViewController = segue.destinationViewController as! MapViewController
            mapViewController.getData(self.usernameTestField.text!, url: self.urlTestField.text!, frequency: self.frequencyTextField.text!)
        }
        
    }
    
}




