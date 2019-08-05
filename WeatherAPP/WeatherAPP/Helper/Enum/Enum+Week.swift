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
            return "일요일"
        case .Mon:
            return "월요일"
        case .Tue:
            return "화요일"
        case .Wed:
            return "수요일"
        case .Thu:
            return "목요일"
        case .Fri:
            return "금요일"
        case .Sta:
            return "토요일"
            
        }
    }
}
