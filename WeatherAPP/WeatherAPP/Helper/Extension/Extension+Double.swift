//
//  Extension+Double.swift
//  WeatherAPP
//
//  Created by hyeri kim on 02/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

extension Double {
    func CelsiusToFahrenheit() -> Double {
        return (self * 1.8) + 32
    }
    
    func FahrenheitToCelsius() -> Double {
        return (self - 32) / 1.8 
    }
}
