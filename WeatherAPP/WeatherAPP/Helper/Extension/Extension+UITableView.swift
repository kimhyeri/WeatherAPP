//
//  Extension+UITableView.swift
//  WeatherAPP
//
//  Created by hyeri kim on 16/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

// MARK: Extension+UITableView
extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable Dequeue Reusable")
        }
    
        return cell
    }
    
    func register<T: UITableViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
}

// MARK: Extension+UITableViewCell
extension UITableViewCell: ReusableCell {}
extension UITableViewCell: NibLoadable {}
