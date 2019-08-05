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
        return (makeDouble() * 1.8) + 32
    }
    
    var fahrenheitToCelsius: Double {
        return (self - 32) / 1.8 
    }
    
    // kelvin to celsius
    var convertC: Double {
        return self - 273.5
    }
        
    // form1 make celsius
    func makeDouble() -> Double {
        guard let celsiusDouble = Double(String(format: "%.2f", arguments: [convertC])) else {
            return 0.0
        }
        return celsiusDouble
    }
    
    var convertF: Double {
        return (self - 273) * 1.8 + 32
    }
    
    // form2 make Fahrenheit
    func makeFahrenheit() -> Double {
        guard let fahrenheitDouble = Double(String(format: "%.2f", arguments: [convertF])) else {
            return 0.0
        }
        return fahrenheitDouble
    }
    
    // form3
    func makeInt() -> Double {
        guard let maxMin = Double(String(format: "%.0f", arguments: [convertC])) else {
            return 0.0
        }
        return maxMin
    }
    
    func makeRound() -> Double {
        return (self*100).rounded()/100
    }
}
