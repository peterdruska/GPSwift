//
//  SwifTime.swift
//  GPSwift
//
//  Created by Peter Druska on 11.3.2015.
//  Copyright (c) 2015 Become.sk. All rights reserved.
//

import Foundation

struct DateAndTime {
    var date = String()
    var time = String()
    var rawValue = NSDate()
}

class SwifTime {
    
    var timeStamp = NSDate()
    var dateAndTime = DateAndTime()
    
    init (timeStamp: NSDate) {
        self.timeStamp = timeStamp
    }
    
    func readTime(dateFormat: String, timeFormat: String) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        dateAndTime.date = formatter.stringFromDate(timeStamp)
        
        formatter.dateFormat = timeFormat
        dateAndTime.time = formatter.stringFromDate(timeStamp)
        
        dateAndTime.rawValue = timeStamp
    }
}