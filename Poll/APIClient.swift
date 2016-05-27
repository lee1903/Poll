//
//  APIClient.swift
//  Poll
//
//  Created by Brian Lee on 5/26/16.
//  Copyright © 2016 brianlee. All rights reserved.
//

import Foundation
import AFNetworking

class APIClient {
    static let http = AFHTTPSessionManager()
    static let apiURL = "http://10.0.0.166:8080/"
    
    private class func getDateString(currentDate: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy / HH:mm:ss"
        let date = dateFormatter.stringFromDate(currentDate) 
        return date
    }
    
    class func getPolls(completion: (polls: [Poll]?, error: NSError?) -> ()){
        
        let url = apiURL + "polls/"
        
        http.GET(url, parameters: [], progress: { (progress: NSProgress) -> Void in
            }, success: { (dataTask: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
                print(response)
                completion(polls: nil, error: nil)
                
                
        }) { (dataTask: NSURLSessionDataTask?, error: NSError) -> Void in
            
            print("failure retrieving ingredients")
            completion(polls: nil, error: error)
        }
    }

    
    class func createPoll(poll: Poll, completion: (error: NSError?) -> ()){
        
        let url = apiURL + "polls/"
        let params = ["title" : "Poll from iOS APP", "date": "\(getDateString(poll.date!))", "optionsCount" : "\(poll.optionsCount!)", "latitude" : "\(poll.location!.coordinate.latitude)", "longitude" : "\(poll.location!.coordinate.longitude)"]
        
        http.POST(url, parameters: params, progress: { (progress: NSProgress) -> Void in
            }, success: { (dataTask: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
                print(response)
                completion(error: nil)
                
                
        }) { (dataTask: NSURLSessionDataTask?, error: NSError) -> Void in
            
            print("failure retrieving ingredients")
            completion(error: error)
        }
    }
}
