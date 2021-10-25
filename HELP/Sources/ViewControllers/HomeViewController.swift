//
//  HomeViewController.swift
//  WUPTB
//
//  Created by Moon on 2021/10/08.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    @IBOutlet weak var lblCurrentCountry: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let country = UserDefaults.standard.string(forKey: "nationName") else { return }
        lblCurrentCountry.text = country
        

    }
    
    func getTest() {
            let url = "https://6155639c93e3550017b08978.mockapi.io/countries"
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json"])
                .validate(statusCode: 200..<300)
                .responseJSON { (json) in
                    print(json)
            }
        }
    
    @IBAction func btnConnectionTestTapped(_ sender: UIButton) {
        getTest()
    }
}
