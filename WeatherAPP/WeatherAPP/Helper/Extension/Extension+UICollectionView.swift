//
//  Extension+UICollectionView.swift
//  WeatherAPP
//
//  Created by hyeri kim on 19/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

// MARK: Extension+UICollectionView
extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable Dequeue Reusable")
        }
        
        return cell
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
}

// MARK: Extension+UICollectionViewCell
extension UICollectionViewCell: ReusableCell {}
extension UICollectionViewCell: NibLoadable {}
