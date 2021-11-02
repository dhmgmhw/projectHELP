//
//  HomeViewController.swift
//  WUPTB
//
//  Created by Moon on 2021/10/08.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func getTest() {
        let url = "http://15.165.137.195:8090/HelpAPI-0.0.3/nation/?secretKey=sixballs-cop&nationCode=AU"
        
        AF.request(url, method: .get).responseJSON { response in
            switch (response.result) {
                // 성공/실패 구분
            case .success:
                // response의 data를 [Nation]로 변환
                print(response)
            case .failure(let error):
                print("에러코드: \(error._code)")
                print("에러사유: \(error.errorDescription!)")
            }
        }.resume()
        
    }
    
    @IBAction func btnConnectionTestTapped(_ sender: UIButton) {
        getTest()
    }
}


