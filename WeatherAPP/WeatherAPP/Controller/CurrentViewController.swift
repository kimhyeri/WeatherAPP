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
    
    var currentWeatherData: WeatherInfo? {
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
    
    @IBAction func webButtonClicked(_ sender: Any) {
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
