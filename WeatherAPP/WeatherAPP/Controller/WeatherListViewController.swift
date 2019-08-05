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
    private let locManager = CLLocationManager()
    private var currentLocation: CLLocation? 

    private var myCities:[Coordinate] = [Coordinate]() {
        didSet {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(myCities), forKey:"cities")
        }
    }
    private var weather:[WeatherInfo] = [WeatherInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }    
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        getCoordinate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        registerNib()
        createObserver()
        fetchCityList()
    }
    
    private func fetchCityList() {
        guard let cities = UserInfo.getCityList() else {
            return
        }
        myCities = cities
        myCities.forEach({
            getWeatherByCoordinate(latitude: $0.lat, longitude: $0.lon)
        })
    }
    
    private func setupViewController() {
        tableView.delegate = self
        tableView.dataSource = self
        locManager.delegate = self
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
        guard let cityCoordinate = notification.object as? CLLocationCoordinate2D else {
            return
        }
        getWeatherByCoordinate(latitude: cityCoordinate.latitude,
                               longitude: cityCoordinate.longitude
        )
        myCities.append(Coordinate(lat: cityCoordinate.latitude, 
                                   lon: cityCoordinate.longitude)
        )
    }
    
    private func getCoordinate() {
        locManager.requestWhenInUseAuthorization()  
    }
    
    private func getWeatherByCoordinate(latitude lat: Double, longitude lon: Double) {
        let parameters: [String: Any] = [
            "lat" : "\(lat)",
            "lon" : "\(lon)",
            "appid" : weatherAPIKey
        ]
        let weatherByCoordinatePath = "/data/2.5/weather"
        
        let request = APIRequest(method: .get,
                                 path: weatherByCoordinatePath,
                                 queryItems: parameters
        )
        
        APICenter().perform(urlString: BaseURL.weatherURL,
                            request: request
        ) { [weak self] (result) in
            guard let self = self else { 
                return
            }
            switch result {
            case .success(let response):        
                if let response = try? response.decode(to: WeatherInfo.self) {
                    self.checkCurrentLocationOrNot(bodyData: response.body)
                } else {
                    print(APIError.decodingFailed)
                }
            case .failure:
                print(APIError.networkFailed)
            }
        }
    }
    
    private func checkCurrentLocationOrNot(bodyData: WeatherInfo) {
        if currentLocation?.coordinate.latitude == bodyData.coord.lat,
            currentLocation?.coordinate.longitude == bodyData.coord.lon {
            weather.insert(bodyData, at: 0)
        } else {
            weather.append(bodyData)
        }
    }
    
    private func getWeatherByCityName(name: String) {    
        let parameters: [String: Any] = [
            "q" : name,
            "appid" : weatherAPIKey
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
            cellType = .Setting
        } else {
            cellType = .City
        }
        
        switch cellType {
        case .City:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListTableViewCell.reuseIdentifier) as? WeatherListTableViewCell else { 
                return UITableViewCell() 
            }
            cell.config(weatherData: (weather[indexPath.row]))
            return cell
        case .Setting:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListSettingTableViewCell.reuseIdentifier) as? WeatherListSettingTableViewCell else { 
                return UITableViewCell() 
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row == weather.count - 1 else { return }
        let weatherData = weather[indexPath.row]
        DispatchQueue.main.async {
            let st = UIStoryboard.init(name: "CurrentWeather", bundle: nil)
            guard let vc = st.instantiateViewController(withIdentifier: "CurrentViewController") as? CurrentViewController else {
                return
            }
            vc.currentWeatherData = weatherData
            self.present(vc, animated: true, completion: nil)
        }
    }
}

// MARK: CLLocationManagerDelegate
extension WeatherListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            guard let currentLocation = locManager.location else {
                return
            }
            getWeatherByCoordinate(latitude: currentLocation.coordinate.latitude,
                                   longitude: currentLocation.coordinate.longitude
            )
        } else {
            print("user denied authorization")
        }
    }
}
