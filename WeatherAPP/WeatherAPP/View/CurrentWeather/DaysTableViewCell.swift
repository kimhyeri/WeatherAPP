//
//  DaysTableViewCell.swift
//  WeatherAPP
//
//  Created by hyeri kim on 05/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class DaysTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getDayString(getData: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let formatDate = dateFormatter.date(from: getData),
            let dayCnt = formatDate.dayNumberOfWeek(), 
            let day = Week(rawValue: dayCnt) else {
            return " "
        }
        return day.StringValue
    }
    
    func config(weather data: List, fc: FahrenheitOrCelsius) {
        dateLabel.text = nil
        switch fc {
        case .Celsius:
            tempMaxLabel.text = data.main.tempMax.makeCelsius() + fc.emoji
            tempMinLabel.text = data.main.tempMin.makeCelsius() + fc.emoji
        case .Fahrenheit:
            tempMaxLabel.text = data.main.tempMax.makeFahrenheit() + fc.emoji
            tempMinLabel.text = data.main.tempMin.makeFahrenheit() + fc.emoji
        }
        
        dateLabel.text = getDayString(getData: data.dtTxt)
        guard let iconName = data.weather.first?.icon else {
            return
        }
        weatherIconImageView.image = UIImage(named: iconName)
    }
}

extension DaysTableViewCell: CellReusable {}
extension DaysTableViewCell: NibLoadable {}
