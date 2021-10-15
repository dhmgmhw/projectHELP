//
//  HomeViewController.swift
//  WUPTB
//
//  Created by Moon on 2021/10/08.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var lblCurrentCountry: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let country = UserDefaults.standard.string(forKey: "name") else { return }
        lblCurrentCountry.text = country
    }
    
}
