//
//  BaseURL.swift
//  WeatherAPP
//
//  Created by hyeri kim on 03/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

//MARK: BaseURL
struct BaseURL {
    static let weatherURL = "https://api.openweathermap.org" 
    static let webURL = "https://weather.com/"
}

//MARK: BasePath
struct BasePath {
    static let list = "/data/2.5/weather"
    static let current = "/data/2.5/forecast"
}
