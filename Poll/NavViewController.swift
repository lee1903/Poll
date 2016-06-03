//
//  NavViewController.swift
//  Poll
//
//  Created by Brian Lee on 5/25/16.
//  Copyright © 2016 brianlee. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class NavViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:0.46, green:0.43, blue:0.56, alpha:1.0)
        
        print(User.currentUser!.name!)
        print(User.currentUser!.email!)
        print(User.currentUser!.id!)
        
        APIClient.getHistory(User.currentUser!.id!) { (polls, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print(polls)
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogout(sender: AnyObject) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut() // this is an instance function
        User.currentUser?.logout()
    }
    
    @IBAction func onCreatePoll(sender: AnyObject) {
        self.performSegueWithIdentifier("SetPollOptions", sender: self)
    }
    
    @IBAction func onTakePoll(sender: AnyObject) {
        self.performSegueWithIdentifier("TakePoll", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
