//
//  Poll.swift
//  Poll
//
//  Created by Brian Lee on 5/26/16.
//  Copyright © 2016 brianlee. All rights reserved.
//

import Foundation

class Poll: NSObject {
    let stats: NSArray?
    let options: NSArray?
    let optionsCount: Int?
    let question: String?
    let title: String?
    let date: NSDate?
    
    init(question: String, options: NSArray, optionsCount: Int) {
        self.question = question
        self.options = options
        self.optionsCount = optionsCount
        
        self.stats = [optionsCount]
        self.title = ""
        self.date = NSDate()
    }
    
    func startSession() {
        
    }
    
    func endSession() {
        
    }
    
}
