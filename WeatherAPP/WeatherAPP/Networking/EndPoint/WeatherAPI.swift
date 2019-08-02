//
//  WeatherAPI.swift
//  WeatherAPP
//
//  Created by hyeri kim on 03/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

enum WeatherAPI {
    case fetchWeatherByCoord(lon: String, lan: String)
    case fetchWeatherByName(city: String)
}

extension WeatherAPI {
    var baseURL: URL {
        guard let url = URL(string: BaseURL.weatherURL) else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchWeatherByCoord:
            return .get
        case .fetchWeatherByName:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .fetchWeatherByCoord(let lon, let lan):
            return ["lon": lon,
                    "lan": lan,
                    "appid": "20aaa3701000f86f51903b62779c4986" 
            ]            
        case .fetchWeatherByName(let city):
            return ["q": city,
                    "appid": "20aaa3701000f86f51903b62779c4986"
            ]
        }
    }
}
