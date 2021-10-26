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
            let url = "http://15.165.137.195:8090/HelpAPI-0.0.1-SNAPSHOT/nation/?secretKey=sixballs-cop"
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
