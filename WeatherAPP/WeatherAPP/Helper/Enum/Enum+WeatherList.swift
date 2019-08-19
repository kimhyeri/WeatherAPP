//
//  Enum+WeatherList.swift
//  WeatherAPP
//
//  Created by hyeri kim on 31/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

enum WeatherListCellType: Int {    
    case City = 0
    case Setting
}

extension WeatherListCellType: CaseIterable {}
