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
    let stats: [[String]]?
    let optionsCount: Int?
    let title: String?
    let date: NSDate?
    let location: CLLocation?
    let author: User?
    var id: String?
    
    init(optionsCount: Int, location: CLLocation, author: User) {
        self.optionsCount = optionsCount
        self.location = location
        self.author = author
        
        self.id = nil
        self.stats = [[String]]()
        
        self.title = ""
        self.date = NSDate()
    }
    
    func startSession() {
        
    }
    
    func endSession() {
        
    }
    
}
