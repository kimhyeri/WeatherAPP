//
//  SearchListTableViewCell.swift
//  WeatherAPP
//
//  Created by hyeri kim on 04/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class SearchListTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func confing(title: String) {
        self.cityNameLabel.text = title
    }
}
