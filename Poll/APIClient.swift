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

    
    class func createPoll(poll: Poll, completion: (response: String?, error: NSError?) -> ()){
        
        let url = apiURL + "polls/"
        let params = ["title" : "\(poll.title!)", "date": "\(getDateString(poll.date!))", "optionsCount" : "\(poll.optionsCount!)", "latitude" : "\(poll.location!.coordinate.latitude)", "longitude" : "\(poll.location!.coordinate.longitude)"]
        
        http.POST(url, parameters: params, progress: { (progress: NSProgress) -> Void in
            }, success: { (dataTask: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
                let id = response!["message"]!
                let res = "\(id!)"
                completion(response: res, error: nil)
                
                
        }) { (dataTask: NSURLSessionDataTask?, error: NSError) -> Void in
            
            print("failure retrieving ingredients")
            completion(response: nil, error: error)
        }
    }
    
    class func endPoll(poll: Poll, completion: (error: NSError?) -> ()){
        
        let url = apiURL + "polls/id=\(poll.id!)"
        
        http.PUT(url, parameters: [], success: { (dataTask: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
                print(response!)
                completion(error: nil)
                
                
        }) { (dataTask: NSURLSessionDataTask?, error: NSError) -> Void in
            
            print("failure retrieving ingredients")
            completion(error: error)
        }
    }
    
    class func joinPoll(id: String, completion: (optionsCount: String?, error: NSError?) -> ()){
        
        let url = apiURL + "polls/id=\(id)"
        
        http.GET(url, parameters: [], progress: { (progress: NSProgress) in }, success: { (dataTask: NSURLSessionDataTask, response: AnyObject?) in
            
            if response != nil {

                let dictionary = response! as! NSDictionary
                
                let optionsCount = dictionary["optionsCount"] as! String
                
                completion(optionsCount: optionsCount, error: nil)
            }
            
        }) { (dataTask: NSURLSessionDataTask?, error: NSError) in
            
                completion(optionsCount: nil, error: error)
        }
    }
}
