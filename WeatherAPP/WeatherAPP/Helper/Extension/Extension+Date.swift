//
//  Extension+Date.swift
//  WeatherAPP
//
//  Created by hyeri kim on 06/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

//MARK: Extension+Date
extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday 
    }
    
    func dayNumberOfWeek(time: Int) -> Int? {
        guard let timeZone = TimeZone(abbreviation: calcuateGMT(time: time)) else {
            return 0
        }
        return Calendar.current.dateComponents(in: timeZone, from: self).weekday
    }
    
    func calcuateGMT(time: Int) -> String {
        let timeZone = abs(time) / 3600
        let compare = time < 0 ? "-" : "+" 

        if timeZone < 10 {
            return "GMT\(compare)0\(timeZone)"
        } else {
            return "GMT\(compare)\(timeZone)"
        }
    }
    
    func getCountryTime(byTimeZone time: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        formatter.timeZone = TimeZone(abbreviation: calcuateGMT(time: time))
        let defaultTimeZoneStr = formatter.string(from: self)
        return defaultTimeZoneStr
    }
}
