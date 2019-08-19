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
    
    private var searchCompleter: MKLocalSearchCompleter = MKLocalSearchCompleter()
    private var searchResults: [MKLocalSearchCompletion] = [MKLocalSearchCompletion]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchBar.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
        registerNib()
    }
    
    private func setupViewController() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchCompleter.delegate = self
    }

    private func registerNib() {
        tableView.register(SearchListTableViewCell.self)
    }

    private func updateSearchResults(selected: MKLocalSearchCompletion) {        
        let searchRequest = MKLocalSearch.Request(completion: selected)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if error != nil {
                print(APIError.requestFailed)
            } 
            let coordinate = response?.mapItems.first?.placemark.coordinate

            NotificationCenter.default.post(name: .selectCity, 
                                            object: coordinate
            )
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: TableView Delegate and DataSource 
extension SearchCitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.config(data: searchResults[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateSearchResults(selected: searchResults[indexPath.row])
    }
}

// MARK: SearchBar Delegate
extension SearchCitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text, 
            searchText.count > 0 else {
                searchResults.removeAll()
                return 
        } 
        searchCompleter.queryFragment = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, 
            searchText.count > 0 else {
                return 
        } 
        searchBar.resignFirstResponder()
    }
}

// MARK: ScrollView Delegate 
extension SearchCitiesViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

// MARK: MKLocalSearchCompleterDelegate
extension SearchCitiesViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(APIError.requestFailed)
    }
}
