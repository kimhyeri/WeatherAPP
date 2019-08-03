//
//  WeatherListViewController.swift
//  WeatherAPP
//
//  Created by hyeri kim on 31/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit
import MapKit

class WeatherListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let selectCity = Notification.Name(selectCityNotification)
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!    
    private var weather:[WeatherInfo] = [WeatherInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }    
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerNib()
        getCoordinate()
        createObserver()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func registerNib() {
        let weatherListCellNib = UINib(nibName: WeatherListTableViewCell.nibName, 
                                       bundle: nil
        )
        tableView.register(weatherListCellNib,
                           forCellReuseIdentifier: WeatherListTableViewCell.reuseIdentifier
        )
        
        let weatherListSettingCellNib = UINib(nibName: WeatherListSettingTableViewCell.nibName, 
                                              bundle: nil
        )
        tableView.register(weatherListSettingCellNib,
                           forCellReuseIdentifier: WeatherListSettingTableViewCell.reuseIdentifier
        )
    }
    
    private func createObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(selectedCity),
                                               name: selectCity, 
                                               object: nil
        )
    }
    
    @objc private func selectedCity(notification: NSNotification) {
        guard let weatherData = notification.object as? MKMapItem else {
            return
        }
        let cityCoordinate = weatherData.placemark.coordinate
        getWeatherByCoordinate(latitude: cityCoordinate.latitude,
                               longitude: cityCoordinate.latitude
        )
    }
    
    private func getCoordinate() {
        locManager.requestWhenInUseAuthorization()
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse ||
            authorizationStatus == CLAuthorizationStatus.authorizedAlways {
            guard let currentLocation = locManager.location else {
                return
            }
            
            getWeatherByCoordinate(latitude: currentLocation.coordinate.latitude,
                                   longitude: currentLocation.coordinate.longitude
            )
        }    
    }
    
    private func getWeatherByCoordinate(latitude lat: Double, longitude lon: Double) {
        let parameters: [String: Any] = [
            "lat" : "\(lat)",
            "lon" : "\(lon)",
            "appid" : "20aaa3701000f86f51903b62779c4986"
        ]
        
        let request = APIRequest(method: .get, queryItems: parameters)
        
        APICenter().perform(urlString: BaseURL.weatherURL,
                            request: request
        ) { [weak self] (result) in
            guard let self = self else { 
                return
            }
            switch result {
            case .success(let response):        
                if let response = try? response.decode(to: WeatherInfo.self) {
                    self.weather.append(response.body)
                    print(response.body)
                }
            case .failure:
                print(APIError.networkFailed)
            }
        }
    }
    
    private func getWeatherByCityName(name: String) {    
        let parameters: [String: Any] = [
            "q" : name,
            "appid" : "20aaa3701000f86f51903b62779c4986"
        ]
        
        let request = APIRequest(method: .get, queryItems: parameters)
        
        APICenter().perform(urlString: BaseURL.weatherURL, 
                            request: request
        ) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):        
                if let response = try? response.decode(to: WeatherInfo.self) {
                    self.weather.append(response.body)
                }
            case .failure:
                print(APIError.networkFailed)
            }
        }
    }
}

// MARK: TableView Deleagate and DataSource
extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellType: WeatherList
        
        if indexPath.row == weather.count  {
            cellType = .setting
        } else {
            cellType = .city
        }
        
        switch cellType {
        case .city:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListTableViewCell.reuseIdentifier) as? WeatherListTableViewCell else { 
                return UITableViewCell() 
            }
            cell.config(weatherData: (weather[indexPath.row]))
            return cell
        case .setting:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListSettingTableViewCell.reuseIdentifier) as? WeatherListSettingTableViewCell else { 
                return UITableViewCell() 
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row == weather.count - 1 else { return }

    }
}
