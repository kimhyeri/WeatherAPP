//
//  Coordinate.swift
//  WeatherAPP
//
//  Created by hyeri kim on 05/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import Foundation

struct Coordinate: Codable {
    let lat: Double
    let lon: Double
}

extension Coordinate: Equatable {}
