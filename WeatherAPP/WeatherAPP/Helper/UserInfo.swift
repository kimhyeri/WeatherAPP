//
//  UserInfo.swift
//  WeatherAPP
//
//  Created by hyeri kim on 05/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

struct UserInfo {
    static func getCityList() -> [Coordinate]? {
        if let cityLists = UserDefaults.standard.value(forKey:"cities") as? Data {
            let cityList = try? PropertyListDecoder().decode(Array<Coordinate>.self, from: cityLists)
            return cityList
        }
        return nil
    }        
    
    static func fahrenheitOrCelsius() -> FahrenheitOrCelsius {
        if let fahrenheitOrCelsius = UserDefaults.standard.object(forKey: "fahrenheitOrCelsius") as? FahrenheitOrCelsius {
            switch fahrenheitOrCelsius {
            case .Fahrenheit:
                return .Fahrenheit
            case .Celsius:
                return .Celsius
            } 
        }
        return FahrenheitOrCelsius.Celsius
    }
}
