//
//  DetailTableViewCell.swift
//  WeatherAPP
//
//  Created by hyeri kim on 05/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var leftDescriptionLabel: UILabel!
    @IBOutlet weak var rightTitleLabel: UILabel!
    @IBOutlet weak var rightDescriptionLabel: UILabel!
    
    var weatherDetailData: WeatherInfo? {
        didSet{
            guard let speed = weatherDetailData?.wind.speed, 
                let humidity = weatherDetailData?.main.humidity else {
                return
            }
            leftDescriptionLabel.text = "\(speed)"
            rightDescriptionLabel.text = "\(humidity)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        leftTitleLabel.text = "wind"
        rightTitleLabel.text = "humidity"

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
