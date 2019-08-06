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
    
    func getTime(time: Int) -> String {
        let timeZone: Int = time / 3600
        var GMT: String = ""
        if timeZone < 10 {
            GMT = "GMT+0\(timeZone)"
        } else {
            GMT = "GMT+\(timeZone)"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        formatter.timeZone = TimeZone(abbreviation: GMT)
        let defaultTimeZoneStr = formatter.string(from: self)
        return defaultTimeZoneStr
    }
}
