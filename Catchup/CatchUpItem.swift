//
//  CatchUpItem.swift
//  Catchup
//
//  Created by Xinxing Jiang on 3/30/16.
//  Copyright © 2016 PalmTech. All rights reserved.
//

import Foundation

class CatchUpItem {
    let name: String!
    var date: NSDate!
    
    init(name: String, date: NSDate) {
        self.name = name
        self.date = date
    }
}