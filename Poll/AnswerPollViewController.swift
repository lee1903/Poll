//
//  AnswerPollViewController.swift
//  Poll
//
//  Created by Brian Lee on 5/27/16.
//  Copyright © 2016 brianlee. All rights reserved.
//

import UIKit

class AnswerPollViewController: UIViewController {
    
    var pollOptions: Int?

    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    @IBOutlet weak var optionE: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if pollOptions! < 5 {
            optionE.alpha = 0.4
            optionE.enabled = false
        }
        if pollOptions! < 4 {
            optionD.alpha = 0.4
            optionD.enabled = false
        }
        if pollOptions! < 3 {
            optionC.alpha = 0.4
            optionC.enabled = false
        }
        if pollOptions! < 2 {
            optionB.alpha = 0.4
            optionB.enabled = false
        }
        
        self.view.backgroundColor = UIColor(red:0.61, green:0.58, blue:0.68, alpha:1.0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) {
        }
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
