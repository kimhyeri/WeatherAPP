//
//  TimesCollectionViewCell.swift
//  WeatherAPP
//
//  Created by hyeri kim on 04/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class TimesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(weather data: Weather) {
        descriptionLabel.text = data.description
        iconImageView.image = UIImage(named: data.icon)
    }
}
