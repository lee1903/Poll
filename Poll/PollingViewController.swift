//
//  PollingViewController.swift
//  Poll
//
//  Created by Brian Lee on 5/26/16.
//  Copyright © 2016 brianlee. All rights reserved.
//

import UIKit
import JBChartView
import Foundation

class PollingViewController: UIViewController, JBBarChartViewDelegate, JBBarChartViewDataSource {
    
    var currentPoll: Poll?

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var barChartView: JBBarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        idLabel.text = "\(currentPoll!.id!)"
        
        self.view.backgroundColor = UIColor(red:0.25, green:0.22, blue:0.37, alpha:1.0)
        
        setupBarChart()
        
        _ = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: #selector(PollingViewController.updateStats), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateStats() {
        APIClient.getPollStats(currentPoll!.id!) { (stats, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                self.currentPoll!.stats = stats!
            }
        }
        
        barChartView.reloadDataAnimated(true)
    }
    
    func setupBarChart() {
        barChartView.delegate = self
        barChartView.dataSource = self
        
        barChartView.backgroundColor = UIColor(red:0.61, green:0.58, blue:0.68, alpha:1.0)
        
        barChartView.reloadDataAnimated(true)
    }
    
    func barChartView(barChartView: JBBarChartView!, colorForBarViewAtIndex index: UInt) -> UIColor! {
        return UIColor(red:0.83, green:0.66, blue:0.42, alpha:1.0)
    }
    
    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
        if currentPoll!.optionsCount == nil {
            return 0
        } else {
            return UInt(currentPoll!.optionsCount!)
        }
    }
    
    func barChartView(barChartView: JBBarChartView!, heightForBarViewAtIndex index: UInt) -> CGFloat {
        if currentPoll!.stats == nil {
            return 0
        } else {
            let height = currentPoll!.stats![Int(index)].count
            return CGFloat(height)
        }
    }
    

    @IBAction func onEnd(sender: AnyObject) {
        APIClient.endPoll(currentPoll!) { (error) in
            if(error != nil) {
                print(error?.localizedDescription)
            } else {
                
            }
        }
    }
    
    @IBAction func onUpdate(sender: AnyObject) {
        updateStats()
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
