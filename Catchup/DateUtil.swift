//
//  DateUtil.swift
//
//  Created by Xinxing Jiang on 4/2/16.
//  Copyright © 2016 PalmTech. All rights reserved.
//

import Foundation

class DateUtil {
    class func isDateValid(month month: Int, day: Int, year: Int) -> Bool {
        return isMonthInRange(month: month) && isDayInRange(month: month, day: day, year: year) && isYearInRange(year: year)
    }
    
    private class func isMonthInRange(month month: Int) -> Bool {
        return month >= 1 && month <= 12
    }
    
    private class func isDayInRange(month month: Int, day: Int, year: Int) -> Bool {
        if day < 1 {
            return false
        }
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            return day <= 31
        case 4, 6, 9, 11:
            return day <= 30
        case 2:
            if isLeapYear(year: year) {
                return day <= 29
            }
            return day <= 28
        default:
            return false
        }
    }
    
    private class func isYearInRange(year year: Int) -> Bool {
        return year > 0 && year < 9999
    }
    
    private class func isLeapYear(year year: Int) -> Bool {
        return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
    }
}