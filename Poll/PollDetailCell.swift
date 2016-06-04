//
//  PollDetailCell.swift
//  Poll
//
//  Created by Brian Lee on 6/3/16.
//  Copyright © 2016 brianlee. All rights reserved.
//

import UIKit

class PollDetailCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var poll: Poll! {
        didSet{
            titleLabel.text = poll.title!
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
            dateLabel.text = dateFormatter.stringFromDate(poll.date!)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
