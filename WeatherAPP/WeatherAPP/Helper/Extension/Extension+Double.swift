//
//  Extension+Double.swift
//  WeatherAPP
//
//  Created by hyeri kim on 02/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

extension Double {
    func makeCelsius() -> String {
        let argue = self - 273.15
        return String(format: "%.0f", arguments: [argue])
    }
    
    func makeFahrenheit() -> String {
        let argue = (self * 9/5) - 459.67
        return String(format: "%.0f", arguments: [argue])
    }
    
    func makeRound() -> Double {
        return (self * 100).rounded()/100
    }
}
