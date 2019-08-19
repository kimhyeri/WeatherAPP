//
//  Enum+CurrentCellType.swift
//  WeatherAPP
//
//  Created by hyeri kim on 12/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

enum CurrentCellType: Int {
    case TimesCell = 0
    case DetailCell 
    case DaysCell 
}

extension CurrentCellType {
    var cellType: UITableViewCell.Type {
        switch self {
        case .DaysCell:
            return DaysTableViewCell.self
        case .DetailCell:
            return DetailTableViewCell.self
        case .TimesCell:
            return CurrentWeatherTimesTableViewCell.self
        }
    }
}
