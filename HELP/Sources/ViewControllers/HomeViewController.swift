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
        AF.request(API.TestURL, method: .get).responseJSON { response in
            switch (response.result) {
                // 성공/실패 구분
            case .success:
                // response의 data를 [Nation]로 변환
                print(response)
            case .failure(let error):
                print("에러코드: \(error._code)")
                print("에러사유: \(error.errorDescription!)")
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


