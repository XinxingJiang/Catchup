//
//  DefaultsUtil.swift
//
//  Created by Xinxing Jiang on 10/2/15.
//  Copyright © 2015 xjiang. All rights reserved.
//

import Foundation

class DefaultsUtil {
    class func getUserDefaults(key key: String) -> AnyObject? {
        return NSUserDefaults.standardUserDefaults().valueForKey(key)
    }
    
    class func setUserDefaults(key key: String, value: AnyObject?) {
        return NSUserDefaults.standardUserDefaults().setValue(value, forKey: key)
    }
}