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
    var pollid: String?
    
    var selectedAnswer: UIButton?

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
    
    func changeSelectedOption(option: UIButton) {
        if selectedAnswer != nil {
            selectedAnswer!.backgroundColor = UIColor(red:0.25, green:0.22, blue:0.37, alpha:1.0)
        }
        selectedAnswer = option
        selectedAnswer!.backgroundColor = UIColor(red:0.45, green:0.07, blue:0.19, alpha:1.0)
    }
    
    @IBAction func onSubmit(sender: AnyObject) {
        if(selectedAnswer == nil) {
            let alert = UIAlertController(title: "Uh oh!", message: "Looks like you haven't selected an answer yet. Please select an answer before submitting.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { action in
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            var response: String?
            
            switch selectedAnswer!.titleLabel!.text! {
            case "A":
                response = "0"
            case "B":
                response = "1"
            case "C":
                response = "2"
            case "D":
                response = "3"
            case "E":
                response = "4"
            default:
                print("error with switch statement")
            }
            
            if response != nil {
                APIClient.answerPoll(pollid!, response: response!) { (error) in
                    if error != nil {
                        print(error?.localizedDescription)
                    } else {
                        print("succesfully answered poll")
                        
                        self.dismissViewControllerAnimated(true) {
                        }
                    }
                }
            } else {
                print("error with switch statement")
            }
            
        }
    }

    @IBAction func onClickA(sender: AnyObject) {
        changeSelectedOption(optionA)
    }
    
    @IBAction func onClickB(sender: AnyObject) {
        changeSelectedOption(optionB)
    }
    
    @IBAction func onClickC(sender: AnyObject) {
        changeSelectedOption(optionC)
    }
    
    @IBAction func onClickD(sender: AnyObject) {
        changeSelectedOption(optionD)
    }
    
    @IBAction func onClickE(sender: AnyObject) {
        changeSelectedOption(optionE)
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
