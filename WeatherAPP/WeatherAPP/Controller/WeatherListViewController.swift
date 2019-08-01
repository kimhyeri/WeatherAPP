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
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    private var weather:[WeatherInfo] = [WeatherInfo]() {
        didSet {
            DispatchQueue.main.sync {
                tableView.reloadData()
            }    
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerNib()
        getCoordinate()
    }
    
    private func getCoordinate() {
        locManager.requestWhenInUseAuthorization()
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse ||
            authorizationStatus == CLAuthorizationStatus.authorizedAlways {
            guard let currentLocation = locManager.location else {
                return
            }
            
            let request = APIRequest(method: .get)
            
            APICenter().perform(urlString: "https://api.openweathermap.org/data/2.5/weather?lat=\(currentLocation.coordinate.latitude)&lon=\(currentLocation.coordinate.longitude)&appid=20aaa3701000f86f51903b62779c4986",
                                request: request) { [weak self] (result) in
                                    guard let self = self else { return }
                                    switch result {
                                    case .success(let response):        
                                        if let response = try? response.decode(to: WeatherInfo.self) {
                                            self.weather.append(response.body)
                                            let data = response.body
                                            print(data)
                                        }
                                    case .failure:
                                        print("Error perform network request")
                                    }
            }
        }    
    }
    
    private func requestWeather() {

        let request = APIRequest(method: .get)

        APICenter().perform(urlString: "https://api.openweathermap.org/data/2.5/weather?q=London&appid=20aaa3701000f86f51903b62779c4986",
                            request: request) { (result) in
                                switch result {
                                case .success(let response):        
                                    if let response = try? response.decode(to: WeatherInfo.self) {
                                        let data = response.body
                                        print(data)
                                    }
                                case .failure:
                                    print("Error perform network request")
                                }
        }
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
        
    }
}
