//
//  HistoryViewController.swift
//  Poll
//
//  Created by Brian Lee on 6/3/16.
//  Copyright © 2016 brianlee. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var polls: [Poll]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        APIClient.getHistory(User.currentUser!.id!) { (polls, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                self.polls = polls
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PollDetailView" {
            let vc = segue.destinationViewController as! PollDetailViewController
            let poll = sender as! Poll
            vc.poll = poll
        }
    }

}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if polls != nil {
            return polls!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PollDetailCell", forIndexPath: indexPath) as! PollDetailCell
        cell.poll = polls![indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("PollDetailView", sender: polls![indexPath.row])
    }
}
