//
//  Enum+FahrenheitOrCelsius.swift
//  WeatherAPP
//
//  Created by hyeri kim on 05/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

enum FahrenheitOrCelsius: String {
    case Fahrenheit = "Fahrenheit"
    case Celsius = "Celsius"
}

extension FahrenheitOrCelsius {
    var emoji: String {
        switch self {
        case .Celsius:
            return "℃"
        case .Fahrenheit:
            return "℉"
        }
    }
}
