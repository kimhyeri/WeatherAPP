//
//  Protocol+ReusableTableViewCell.swift
//  WeatherAPP
//
//  Created by hyeri kim on 16/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String { 
        return String(describing: self)
    }
}
