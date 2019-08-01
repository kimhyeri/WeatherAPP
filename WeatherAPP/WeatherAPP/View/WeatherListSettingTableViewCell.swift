//
//  WeatherListSettingTableViewCell.swift
//  WeatherAPP
//
//  Created by hyeri kim on 31/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class WeatherListSettingTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func findCityButtonClicked(_ sender: UIButton) {
        let st = UIStoryboard.init(name: "WeatherList", bundle: nil)
        guard let vc = st.instantiateViewController(withIdentifier: "SearchCitiesViewController") as? SearchCitiesViewController else {
            return 
        }
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
}

extension WeatherListSettingTableViewCell: CellReusable {}
extension WeatherListSettingTableViewCell: NibLoadable {}
