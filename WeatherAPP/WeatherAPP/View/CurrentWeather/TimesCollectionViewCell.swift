//
//  TimesCollectionViewCell.swift
//  WeatherAPP
//
//  Created by hyeri kim on 04/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class TimesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nowLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(weather data: Weather) {
        idLabel.text = "\(data.id)"
        descriptionLabel.text = data.description
        iconImageView.image = UIImage(named: data.icon)
    }
}

extension TimesCollectionViewCell: CellReusable {}
extension TimesCollectionViewCell: NibLoadable {}
