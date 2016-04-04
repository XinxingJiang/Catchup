//
//  TableViewCell.swift
//  Catchup
//
//  Created by Xinxing Jiang on 4/4/16.
//  Copyright © 2016 PalmTech. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var item: [String: String]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.text = item["name"]
        dateLabel.text = item["date"]
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
