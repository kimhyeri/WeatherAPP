//
//  WeatherListSettingTableViewCell.swift
//  WeatherAPP
//
//  Created by hyeri kim on 31/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class WeatherListSettingTableViewCell: UITableViewCell {

    @IBOutlet weak var toggleButton: UIButton!
    
    private var fahrenheitOrCelsius: FahrenheitOrCelsius? {
        didSet {
            UserDefaults.standard.set(fahrenheitOrCelsius?.rawValue, forKey: "fahrenheitOrCelsius")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func celsiusFahrenheitButtonClicked(_ sender: UIButton) {
        if fahrenheitOrCelsius == .Celsius {
            fahrenheitOrCelsius = .Fahrenheit
        } else {
            fahrenheitOrCelsius = .Celsius
        }
        DispatchQueue.global().async {
            let selectedFahrenheitOrCelsius = Notification.Name(rawValue: selectFahrenheitOrCelsiusNotification)
            NotificationCenter.default.post(name: selectedFahrenheitOrCelsius,
                                            object: self.fahrenheitOrCelsius
            )
        }
    }
    
    @IBAction func findCityButtonClicked(_ sender: UIButton) {
        let st = UIStoryboard.init(name: "SearchCity", bundle: nil)
        guard let vc = st.instantiateViewController(withIdentifier: "SearchCitiesViewController") as? SearchCitiesViewController else {
            return 
        }
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func webButtonClicked(_ sender: UIButton) {
        guard let webURL = URL(string: BaseURL.webURL) else { 
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(webURL)
        }
    }
}

extension WeatherListSettingTableViewCell: CellReusable {}
extension WeatherListSettingTableViewCell: NibLoadable {}
