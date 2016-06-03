//
//  Poll.swift
//  Poll
//
//  Created by Brian Lee on 5/26/16.
//  Copyright © 2016 brianlee. All rights reserved.
//

import Foundation
import CoreLocation

class Poll: NSObject {
    var stats: [[String]]?
    let optionsCount: Int?
    let title: String?
    let date: NSDate?
    let location: CLLocation?
    let author: User?
    let author_id: String?
    var id: String?
    
    init(optionsCount: Int, location: CLLocation, author: User) {
        self.optionsCount = optionsCount
        self.location = location
        self.author = author
        self.author_id = author.id!
        
        self.id = nil
        self.stats = [[String]]()
        
        self.title = ""
        self.date = NSDate()
    }
    
    init(dictionary: NSDictionary) {
        self.stats = dictionary["stats"] as? [[String]]
        self.optionsCount = Int((dictionary["optionsCount"] as! String))
        self.title = dictionary["title"] as? String
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy / HH:mm:ss"
        let date = dateFormatter.dateFromString(dictionary["date"] as! String)
        self.date = date
        
        let lat = (dictionary["latitude"] as! NSString).doubleValue
        let long = (dictionary["longitude"] as! NSString).doubleValue
        let pollLocation = CLLocation(latitude: lat, longitude: long)
        
        self.location = pollLocation
        //need create init for user from dictionary so can add full user here
        self.author = nil
        self.author_id = dictionary["author"] as? String
        self.id = nil
        
    }
    
    func startSession() {
        
    }
    
    func endSession() {
        
    }
    
}
