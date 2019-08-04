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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(weather data: List) {
        tempMaxLabel.text = "\(data.main.tempMax.makeCelsius())"
        tempMinLabel.text = "\(data.main.tempMin.makeCelsius())"
        dateLabel.text = data.dtTxt

    }
}

extension DaysTableViewCell: CellReusable {}
extension DaysTableViewCell: NibLoadable {}
