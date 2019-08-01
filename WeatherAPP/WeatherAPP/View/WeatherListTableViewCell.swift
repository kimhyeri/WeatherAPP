//
//  WeatherListTableViewCell.swift
//  WeatherAPP
//
//  Created by hyeri kim on 31/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class WeatherListTableViewCell: UITableViewCell {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(weatherData: WeatherInfo) {
        cityNameLabel.text = weatherData.name
        timeLabel.text = "\(weatherData.timezone)"
        temperatureLabel.text = "\(weatherData.main.temp)"
    }
    
}

extension WeatherListTableViewCell: CellReusable {}
extension WeatherListTableViewCell: NibLoadable {}
