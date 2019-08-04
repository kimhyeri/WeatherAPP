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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        registerNib()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerNib() {
        let timesNib = UINib(nibName: CurrentWeatherTimesTableViewCell.nibName, 
                             bundle: nil
        )
        tableView.register(timesNib, forCellReuseIdentifier: CurrentWeatherTimesTableViewCell.reuseIdentifier
        )
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
    }
}

extension CurrentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherTimesTableViewCell.reuseIdentifier, for: indexPath) as? CurrentWeatherTimesTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
