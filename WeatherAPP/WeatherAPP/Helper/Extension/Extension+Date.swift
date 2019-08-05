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
}
