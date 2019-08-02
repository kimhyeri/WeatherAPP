//
//  Extension+URL.swift
//  WeatherAPP
//
//  Created by hyeri kim on 02/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

// MAKR: Default URL
extension URL {
    static func forCityWeather(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=20aaa3701000f86f51903b62779c4986")
    }
    
    static func forCityWeather(lat: Double, lon: Double) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=20aaa3701000f86f51903b62779c4986")
    }
}

