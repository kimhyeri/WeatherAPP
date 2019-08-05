//
//  Extension+Double.swift
//  WeatherAPP
//
//  Created by hyeri kim on 02/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

extension Double {
    var celsiusToFahrenheit: Double {
        return (self * 1.8) + 32
    }
    
    var fahrenheitToCelsius: Double {
        return (self - 32) / 1.8 
    }
    
    // kelvin to celsius
    var convert: Double {
        return self - 273.5
    }
    
    // form1
    func makeDouble() -> Double {
        guard let celsiusDouble = Double(String(format: "%.2f", arguments: [convert])) else {
            return 0.0
        }
        return celsiusDouble
    }
    
    // form2
    func makeInt() -> Double {
        guard let maxMin = Double(String(format: "%.0f", arguments: [convert])) else {
            return 0.0
        }
        return maxMin
    }
    
    func makeRound() -> Double {
        return (self*100).rounded()/100
    }
}
