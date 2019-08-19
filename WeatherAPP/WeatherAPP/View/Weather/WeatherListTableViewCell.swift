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
    
    var weatherData: WeatherInfo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Timer.scheduledTimer(timeInterval: 60,
                             target: self, 
                             selector: #selector(updateTime),
                             userInfo: nil,
                             repeats: true
        )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc private func updateTime() {
        guard let timezone = weatherData?.timezone else {
            return
        }
        timeLabel.text = Date().getCountryTime(byTimeZone: timezone)
    }
    
    func config(weatherInfoData: WeatherInfo, fahrenheitOrCelsius: FahrenheitOrCelsius) {
        weatherData = weatherInfoData
        updateTime()
        cityNameLabel.text = weatherInfoData.name
        switch fahrenheitOrCelsius {
        case .Celsius:
            temperatureLabel.text = weatherInfoData.main.temp.makeCelsius() + 
                fahrenheitOrCelsius.emoji
        case .Fahrenheit:
            temperatureLabel.text = weatherInfoData.main.temp.makeFahrenheit() +
                fahrenheitOrCelsius.emoji
        }
    }
}
