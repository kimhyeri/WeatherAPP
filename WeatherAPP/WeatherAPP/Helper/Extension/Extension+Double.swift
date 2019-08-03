//
//  Extension+Double.swift
//  WeatherAPP
//
//  Created by hyeri kim on 02/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

extension Double {
    func celsiusToFahrenheit() -> Double {
        return (self * 1.8) + 32
    }
    
    func fahrenheitToCelsius() -> Double {
        return (self - 32) / 1.8 
    }
    
    // kelvin temperature to celsius
    func makeCelsius() -> String {
        let celsius = self - 273.5
        return String(format: "%.2f", arguments: [celsius]) 
    }
}
