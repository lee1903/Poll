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

class PollingViewController: UIViewController {
    
    var currentPoll: Poll?
    let colors = [UIColor(red:1.00, green:0.83, blue:0.57, alpha:1.0), UIColor(red:0.57, green:0.93, blue:1.00, alpha:1.0), UIColor(red:1.00, green:0.56, blue:0.62, alpha:1.0), UIColor(red:1.00, green:0.96, blue:0.57, alpha:1.0), UIColor(red:0.78, green:1.00, blue:0.57, alpha:1.0)]

    var barViews: [UIView] = [UIView(), UIView(), UIView(), UIView(), UIView()]
    var labelsHidden = true

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var barChartView: JBBarChartView!
    @IBOutlet weak var barChartContainerView: UIView!
    @IBOutlet weak var singleCounterLabel: UILabel!
    
    @IBOutlet weak var aCountLabel: UILabel!
    @IBOutlet weak var bCountLabel: UILabel!
    @IBOutlet weak var cCountLabel: UILabel!
    @IBOutlet weak var dCountLabel: UILabel!
    @IBOutlet weak var eCountLabel: UILabel!
    @IBOutlet weak var counterContainerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        idLabel.text = "\(currentPoll!.id!)"
        
        self.view.backgroundColor = UIColor(red:0.25, green:0.22, blue:0.37, alpha:1.0)
        
        setupBarChart()
        setupBarViews()
        hideTotalLabels()
        
        singleCounterLabel.hidden = true
        
        if currentPoll!.optionsCount! == 1 {
            counterContainerView.hidden = true
            barChartContainerView.hidden = true
            singleCounterLabel.hidden = false
            singleCounterLabel.text = "0"
        }
        
        _ = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: #selector(PollingViewController.updateStats), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
         setupTotalLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideTotalLabels() {
        aCountLabel.alpha = 0
        bCountLabel.alpha = 0
        cCountLabel.alpha = 0
        dCountLabel.alpha = 0
        eCountLabel.alpha = 0
    }
    
    func showTotalLabels() {
        UIView.animateWithDuration(1.0) {
            self.aCountLabel.alpha = 1
            self.bCountLabel.alpha = 1
            self.cCountLabel.alpha = 1
            self.dCountLabel.alpha = 1
            self.eCountLabel.alpha = 1
        }
        
        labelsHidden = false
    }
    
    func setupBarViews() {
        
        for i in 0...4 {
            barViews[i].backgroundColor = colors[i]
        }

    }
    
    func updateStats() {
        APIClient.getPollStats(currentPoll!.id!) { (stats, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                self.currentPoll!.stats = stats!
            }
        }
        
        if currentPoll!.optionsCount! == 1 {
            singleCounterLabel.text = "\(self.currentPoll!.stats![0].count)"
        } else {
            barChartView.reloadDataAnimated(true)
            updateTotalLabels()
        }

    }
    
    func setupTotalLabels() {
        if currentPoll!.optionsCount! > 1 {
            aCountLabel.center = CGPoint(x: (barViews[0].center.x), y: (counterContainerView.frame.height/2))
            bCountLabel.center = CGPoint(x: (barViews[1].center.x), y: (counterContainerView.frame.height/2))
        }
        if currentPoll!.optionsCount! > 2 {
            cCountLabel.center = CGPoint(x: (barViews[2].center.x), y: (counterContainerView.frame.height/2))
        }
        if currentPoll!.optionsCount! > 3 {
            dCountLabel.center = CGPoint(x: (barViews[3].center.x), y: (counterContainerView.frame.height/2))
        }
        if currentPoll!.optionsCount! > 4 {
            eCountLabel.center = CGPoint(x: (barViews[4].center.x), y: (counterContainerView.frame.height/2))
        }
        
        if currentPoll!.optionsCount! < 2 {
            aCountLabel.hidden = true
            bCountLabel.hidden = true
        }
        if currentPoll!.optionsCount! < 3 {
            cCountLabel.hidden = true
        }
        if currentPoll!.optionsCount! < 4 {
            dCountLabel.hidden = true
        }
        if currentPoll!.optionsCount! < 5 {
            eCountLabel.hidden = true
        }
        
    }
    
    func updateTotalLabels() {
        if labelsHidden {
            var count = 0
            for i in 0...(currentPoll!.optionsCount!-1) {
                count += currentPoll!.stats![i].count
            }
            
            if count > 0 {
                showTotalLabels()
            }
        }
        
        if currentPoll!.optionsCount! > 1 {
            aCountLabel.text = "\(currentPoll!.stats![0].count)"
            bCountLabel.text = "\(currentPoll!.stats![1].count)"
        }
        if currentPoll!.optionsCount! > 2 {
            cCountLabel.text = "\(currentPoll!.stats![2].count)"
        }
        if currentPoll!.optionsCount! > 3 {
            dCountLabel.text = "\(currentPoll!.stats![3].count)"
        }
        if currentPoll!.optionsCount! > 4 {
            eCountLabel.text = "\(currentPoll!.stats![4].count)"
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PollingViewController: JBBarChartViewDelegate, JBBarChartViewDataSource {
    func setupBarChart() {
        barChartView.delegate = self
        barChartView.dataSource = self
        
        barChartView.backgroundColor = UIColor.clearColor()
        barChartView.minimumValue = CGFloat(0)
        barChartView.maximumValue = CGFloat(5)
        
        barChartView.reloadDataAnimated(true)
    }
    
//    func barChartView(barChartView: JBBarChartView!, colorForBarViewAtIndex index: UInt) -> UIColor! {
//        return colors[Int(index)]
//    }
    
    func barChartView(barChartView: JBBarChartView!, barViewAtIndex index: UInt) -> UIView! {
        return barViews[Int(index)]
    }
    
    func barSelectionColorForBarChartView(barChartView: JBBarChartView!) -> UIColor! {
        return UIColor.clearColor()
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
}
