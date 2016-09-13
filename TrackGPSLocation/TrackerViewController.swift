//
//  ViewController.swift
//  TrackGPSLocation
//
//  Created by GrepRuby1 on 13/09/16.
//  Copyright © 2016 GrepRuby. All rights reserved.
//

import UIKit

class TrackerViewController: UIViewController {
    
    @IBOutlet weak private var usernameTestField: UITextField!
    @IBOutlet weak private var urlTestField: UITextField!
    @IBOutlet weak private var frequencyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        callInTime(self.frequencyTextField.text!, url: self.urlTestField.text!)
    }
    
}

//MARK:- To delete

extension TrackerViewController {
    func callInTime(time: String, url: String) {
        NSTimer.scheduledTimerWithTimeInterval(15.0, target: self, selector: #selector(TrackerViewController.callFunction), userInfo: nil, repeats: true)
    }
    
    func callFunction() {
        print("Abbas")
    }
}

