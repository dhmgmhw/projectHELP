//
//  SearchViewController.swift
//  HELP
//
//  Created by Moon on 2021/10/14.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {

    @IBOutlet weak var tvCountries: UITableView!
    let searchController = UISearchController()
    let list = countries
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "CountryCell", bundle: nil)
        tvCountries.register(nibName, forCellReuseIdentifier: "CountryCell")
        tvCountries.delegate = self
        tvCountries.dataSource = self
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryName = self.list[indexPath.row]["name"]
        let countryCode = self.list[indexPath.row]["nationalCode"]
        
        UserDefaults.standard.set(countryName, forKey: "name")
        UserDefaults.standard.set(countryCode, forKey: "nationalCode")
        dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell else { return UITableViewCell() }
        cell.lblCountry.text = "\(countries[indexPath.row]["name"]!)"
        cell.imgFlag.image = UIImage(named: "\(countries[indexPath.row]["nationalCode"]!.lowercased()).png")
        return cell
    }

}
