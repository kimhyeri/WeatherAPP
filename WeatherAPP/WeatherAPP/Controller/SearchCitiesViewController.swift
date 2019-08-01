//
//  SearchCitiesViewController.swift
//  WeatherAPP
//
//  Created by hyeri kim on 01/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit
import MapKit

class SearchCitiesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var matchingItems:[MKMapItem] = [] 
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.searchBar.becomeFirstResponder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }

    private func setupViewController() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func updateSearchResults(searchBarText: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}

// MARK: TableView Delegate and DataSource 
extension SearchCitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        return cell
    }
}

// MARK: SearchBar Delegate
extension SearchCitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text else { return }
        updateSearchResults(searchBarText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: ScrollView Delegate 
extension SearchCitiesViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
