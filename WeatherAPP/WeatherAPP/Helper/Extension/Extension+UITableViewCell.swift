//
//  Extension+UITableViewCell.swift
//  WeatherAPP
//
//  Created by hyeri kim on 16/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

// MARK: Extension+UITableViewCell
extension UITableViewCell: ReusableTableViewCell {}

// MARK: Extension+UITableView
extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable Dequeue Reusable")
        }
        return cell
    }
}
