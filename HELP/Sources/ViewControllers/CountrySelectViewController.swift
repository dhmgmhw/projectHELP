//
//  CountrySelectViewController.swift
//  HELP
//
//  Created by Moon on 2021/10/12.
//

import UIKit

class CountrySelectViewController: UIViewController {
    @IBOutlet weak var tableViewCountry: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: "CountryCell", bundle: nil)
        tableViewCountry.register(nibName, forCellReuseIdentifier: "CountryCell")
        
        tableViewCountry.delegate = self
        tableViewCountry.dataSource = self
    }
    
    @IBOutlet weak var tableView: UITableView!
    
}

extension CountrySelectViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
}

extension CountrySelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell else { return UITableViewCell() }
        return cell
    }
}
