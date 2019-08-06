//
//  Extension+Date.swift
//  WeatherAPP
//
//  Created by hyeri kim on 06/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday 
    }
    
    func getGMT(time: Int) -> String {
        if time < 0 {
            let timeZone = abs(time) / 3600
            if timeZone < 10 {
                return "GMT-0\(timeZone)"
            } else {
                return "GMT-\(timeZone)"
            }
        } 
        let timeZone: Int = time / 3600
        if timeZone < 10 {
            return "GMT+0\(timeZone)"
        } else {
            return "GMT+\(timeZone)"
        }
    }
    
    func getTime(time: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        formatter.timeZone = TimeZone(abbreviation: getGMT(time: time))
        let defaultTimeZoneStr = formatter.string(from: self)
        return defaultTimeZoneStr
    }
    
    func dayNumberOfWeek(time: Int) -> Int? {
        guard let timeZone = TimeZone(abbreviation: getGMT(time: time)) else {
            return 0
        }
        let component =  Calendar.current.dateComponents(in: timeZone, from: self)
        return  component.weekday
    }
}
