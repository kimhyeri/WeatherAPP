//
//  CellReusable.swift
//  WeatherAPP
//
//  Created by hyeri kim on 31/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

protocol CellReusable: class {}

extension CellReusable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return "Cell"
    }
}
