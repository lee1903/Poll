//
//  JoinPollViewController.swift
//  Poll
//
//  Created by Brian Lee on 5/27/16.
//  Copyright © 2016 brianlee. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class JoinPollViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var takePollMapView: MKMapView!

    var currentLocation: CLLocation?
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeTextField.delegate = self
        codeTextField.becomeFirstResponder()
        codeTextField.addTarget(self, action: #selector(JoinPollViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)

        codeTextField.text = ""
        
        takePollMapView.delegate = self
        
        setupLocationServices()
        
        self.view.backgroundColor = UIColor(red:0.61, green:0.58, blue:0.68, alpha:1.0)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        codeTextField.text = ""
    }
    
    override func viewDidAppear(animated: Bool) {
        codeTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onJoin(sender: AnyObject) {
        APIClient.joinPoll(codeTextField.text!) { (optionsCount, error) in
            if error != nil {
                print(error?.localizedDescription)
                
                let alert = UIAlertController(title: "Uh oh!", message: "Unable to join this poll. Check to make sure you have the right code and that your location services is on.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { action in
                    self.codeTextField.text = ""
                    self.codeTextField.becomeFirstResponder()
                }))
                self.presentViewController(alert, animated: true, completion: nil)
                
            } else {
                self.performSegueWithIdentifier("AnswerPoll", sender: optionsCount!)
            }
        }
    }
    
    //location functions
    
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
        takePollMapView.addAnnotation(annotation)
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
        takePollMapView.setRegion(coordinateRegion, animated: true)
    }
    
    //textField functions
    
    func textFieldDidChange(textField: UITextField) {
        if(codeTextField.text!.characters.count == 4) {
            codeTextField.resignFirstResponder()
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 4 // Bool
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AnswerPoll" {
            let vc = segue.destinationViewController as! AnswerPollViewController
            let str = sender! as! String
            vc.pollOptions = Int(str)
        }
    }

}
