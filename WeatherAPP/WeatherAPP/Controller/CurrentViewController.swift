//
//  CurrentViewController.swift
//  WeatherAPP
//
//  Created by hyeri kim on 31/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class CurrentViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    
    var currentWeatherData: WeatherInfo? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.updateUI()
            }
        }
    }
    private var fiveDayWeatherData: FiveDayWeather? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var fahrenheitOrCelsius: FahrenheitOrCelsius? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            } 
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        fetchFahrenheitOrCelsius()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        registerNib()
    }
    
    private func fetchFahrenheitOrCelsius() {
        fahrenheitOrCelsius = FahrenheitOrCelsius(rawValue: UserInfo.fahrenheitOrCelsius())
    }
    
    private func fetchData() {
        guard let coordinate = currentWeatherData?.coord else {
            return
        }
        
        self.get5DayWeatherByCoordinate(latitude: coordinate.lat,
                                        longitude: coordinate.lon
        )
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerNib() {
        let timesNib = UINib(nibName: CurrentWeatherTimesTableViewCell.nibName, 
                             bundle: nil
        )
        tableView.register(timesNib, 
                           forCellReuseIdentifier: CurrentWeatherTimesTableViewCell.timesReuseIdentifier
        )
        
        let daysNib = UINib(nibName: DaysTableViewCell.nibName,
                           bundle: nil
        )
        tableView.register(daysNib,
                           forCellReuseIdentifier: DaysTableViewCell.daysReuseIdentifier
        )
        
        let detailNib = UINib(nibName: DetailTableViewCell.nibName,
                            bundle: nil
        )
        tableView.register(detailNib,
                           forCellReuseIdentifier: DetailTableViewCell.detailReuseIdentifier
        )
    }
    
    private func get5DayWeatherByCoordinate(latitude lat: Double, longitude lon: Double) {
        let parameters: [String: Any] = [
            "lat" : "\(lat)",
            "lon" : "\(lon)",
            "appid" : weatherAPIKey
        ]
        
        let day5WeatherByCoordinatePath = "/data/2.5/forecast"
        
        let request = APIRequest(method: .get, path: day5WeatherByCoordinatePath, queryItems: parameters)
        
        APICenter().perform(urlString: BaseURL.weatherURL,
                            request: request
        ) { [weak self] (result) in
            guard let self = self else { 
                return
            }
            switch result {
            case .success(let response):   
                if let response = try? response.decode(to: FiveDayWeather.self) {
                    self.fiveDayWeatherData = response.body
                } else {
                    print(APIError.decodingFailed)
                }
            case .failure:
                print(APIError.networkFailed)
            }
        }
    }
    
    @IBAction func listButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
    
    private func updateUI() {
        guard let weather = currentWeatherData else {
            return
        }
        cityNameLabel.text = weather.name
        weatherStatusLabel.text = weather.weather.first?.description
    }
}

extension CurrentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = fiveDayWeatherData?.list else {
            return 1
        } 
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherTimesTableViewCell.timesReuseIdentifier, for: indexPath) as? CurrentWeatherTimesTableViewCell,
                let weatherData = currentWeatherData?.weather else {
                return UITableViewCell()
            }
            cell.config(weather: weatherData)
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.detailReuseIdentifier, for: indexPath) as? DetailTableViewCell,
                let weatherData = currentWeatherData else {
                    return UITableViewCell()
            }
            cell.config(weather: weatherData)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DaysTableViewCell.daysReuseIdentifier, for: indexPath) as? DaysTableViewCell, 
                let list = fiveDayWeatherData?.list, let fahrenheitOrCelsiusData = fahrenheitOrCelsius else {
                return UITableViewCell()
            }
            cell.config(weather: list[indexPath.row], fc: fahrenheitOrCelsiusData)
            return cell
        }
    }
}
