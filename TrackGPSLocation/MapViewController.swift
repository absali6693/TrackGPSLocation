//
//  MapViewController.swift
//  TrackGPSLocation
//
//  Created by GrepRuby1 on 14/09/16.
//  Copyright © 2016 GrepRuby. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    
    let gpsLocationTracker = GPSLocationTracker()
    let regionRadius: CLLocationDistance = 100
    
    private var username: String?
    private var url: String?
    private var locations: CLLocation?

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gpsLocationTracker.delegate = self
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension MapViewController {
    
    func getData(username: String, url: String, frequency: String) {
        NSTimer.scheduledTimerWithTimeInterval(Double(frequency) ?? 2.0, target: self, selector: #selector(self.getLocation), userInfo: nil, repeats: true)
        self.username = username
        self.url = url
    }
    
    func getLocation() {
        gpsLocationTracker.track()
    }
    
    func sendData(locations: CLLocation) {
        
        let sendDataToServer = SendDataToServer()
        sendDataToServer.sendData(self.username!, url:self.url!, locations: locations)
    }
}

extension MapViewController: DetailViewControllerDelegate {
    
        func didFinishTask(locations: CLLocation) {
            self.locations = locations
            sendData(locations)
            let initialLocation = CLLocation(latitude: self.locations!.coordinate.latitude, longitude: self.locations!.coordinate.longitude)
            centerMapOnLocation(initialLocation)
            mapView.showsUserLocation = true
            print(mapView.userLocationVisible)
        }
}

