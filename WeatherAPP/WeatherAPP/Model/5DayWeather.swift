//
//  5DayWeather.swift
//  WeatherAPP
//
//  Created by hyeri kim on 05/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

// MARK: - The5DayWeather
struct FiveDayWeather: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone: Int
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [fiveWeather]
    let clouds: Clouds
    let wind: fiveWind
    let sys: fiveSys
    let dtTxt: String
    let rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, tempMin, tempMax, pressure: Double
    let seaLevel, grndLevel: Double
    let humidity: Int
    let tempKf: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let threeH: Double
    
    enum CodingKeys: String, CodingKey {
        case threeH = "3h"
    }
}

// MARK: - Sys
struct fiveSys: Codable {
    let pod: String
}

// MARK: - Weather
struct fiveWeather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: - Wind
struct fiveWind: Codable {
    let speed: Double
    let deg: Double
}
