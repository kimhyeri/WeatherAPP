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
                             userInfo: nil, repeats: true
        )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc private func updateTime() {
        guard let timezone = weatherData?.timezone else {
            return
        }
        timeLabel.text = Date().getTime(time: timezone)
    }
    
    func config(weatherData: WeatherInfo, fc: FahrenheitOrCelsius) {
        cityNameLabel.text = weatherData.name
        self.weatherData = weatherData
        timeLabel.text = Date().getTime(time: weatherData.timezone)
        switch fc {
        case .Celsius:
            temperatureLabel.text = weatherData.main.temp.makeCelsius() + fc.emoji
        case .Fahrenheit:
            temperatureLabel.text = weatherData.main.temp.makeFahrenheit() + fc.emoji
        }
    }
}

extension WeatherListTableViewCell: CellReusable {}
extension WeatherListTableViewCell: NibLoadable {}
