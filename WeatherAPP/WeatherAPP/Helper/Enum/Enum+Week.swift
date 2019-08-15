//
//  Enum+Week.swift
//  WeatherAPP
//
//  Created by hyeri kim on 06/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

enum Week: Int {
    case Sun = 1
    case Mon
    case Tue
    case Wed
    case Thu
    case Fri
    case Sta
}

extension Week {
    var StringValue: String {
        switch self {
        case .Sun:
            return "Sunday"
        case .Mon:
            return "Monday"
        case .Tue:
            return "Tuesday"
        case .Wed:
            return "Wednesday"
        case .Thu:
            return "Thursday"
        case .Fri:
            return "Friday"
        case .Sta:
            return "Saturday"
        }
    }
}
