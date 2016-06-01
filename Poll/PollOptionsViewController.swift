//
//  PollOptionsViewController.swift
//  Poll
//
//  Created by Brian Lee on 5/26/16.
//  Copyright © 2016 brianlee. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class PollOptionsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var numOptions: Int?
    var currentLocation: CLLocation?
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        setupLocationServices()
        
        self.view.backgroundColor = UIColor(red:0.25, green:0.22, blue:0.37, alpha:1.0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupLocationServices() {
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func getCurrentLocation() {
        centerMapOnLocation(currentLocation!)
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation!.coordinate
        mapView.addAnnotation(annotation)
    }
    
    @IBAction func onNumOptionsChange(sender: AnyObject) {
        let segControl = sender as! UISegmentedControl
        numOptions = segControl.selectedSegmentIndex + 1
    }
    
    @IBAction func onCreatePoll(sender: AnyObject) {
        if(numOptions == nil) {
            numOptions = 1
        }
        
        let poll = Poll(optionsCount: numOptions!, location: currentLocation!, author: User.currentUser!)
        
        APIClient.createPoll(poll) { (response, error) -> () in
            if error != nil{
                print(error?.localizedDescription)
            } else {
                poll.id = response!
                
                APIClient.getPollStats(poll.id!) { (stats, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                    } else {
                        poll.stats = stats!
                        self.performSegueWithIdentifier("CreatePollWithOptions", sender: poll)
                    }
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue = manager.location!
        
        if currentLocation == nil {
            currentLocation = locValue
            getCurrentLocation()
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CreatePollWithOptions" {
            let vc = segue.destinationViewController as! PollingViewController
            let poll = sender as! Poll
            vc.currentPoll = poll
        }
    }

}
