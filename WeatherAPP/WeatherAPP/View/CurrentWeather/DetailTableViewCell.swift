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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(weather data: WeatherInfo) {
        leftTitleLabel.text = "바람"
        leftDescriptionLabel.text = "\(data.wind.speed)"
        rightTitleLabel.text = "습도"
        rightDescriptionLabel.text = "\(data.main.humidity)"
        
    }
}

extension DetailTableViewCell: CellReusable {}
extension DetailTableViewCell: NibLoadable {}
