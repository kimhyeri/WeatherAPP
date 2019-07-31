//
//  WeatherListViewController.swift
//  WeatherAPP
//
//  Created by hyeri kim on 31/07/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class WeatherListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let weatherListCellNib = UINib(nibName: WeatherListTableViewCell.nibName, bundle: nil)
        tableView.register(weatherListCellNib, forCellReuseIdentifier: WeatherListTableViewCell.reuseIdentifier)
    }

}

// MARK: TableView Deleagate and DataSource

extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListTableViewCell.reuseIdentifier) as? WeatherListTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Current Weather
    }
}
