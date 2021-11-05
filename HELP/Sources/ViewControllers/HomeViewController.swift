//
//  HomeViewController.swift
//  WUPTB
//
//  Created by Moon on 2021/10/08.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    @IBOutlet weak var textInput: UITextField!
    
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
    
    @IBAction func btnConnectionTestTapped(_ sender: UIButton) {
        getTest()
    }
    
    @IBAction func btnPostTestTapped(_ sender: UIButton) {
        if textInput.text == "" {
            let alert = UIAlertController(title: "알림", message: "텍스트를 입력해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "알았어요", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            LoadingIndicator.showLoading()
            guard let text = textInput.text else { return }
            let url = "\(API.MockURL)/countries"
            let param = NationElement(nationCode: "KR", nationName: "\(text)", policeCall: "123124", fireCall: "124123", embassyCall: "1245123", embassyLoc: "종로구 우미관")
            AF.request(url,
                       method: .post,
                       parameters: param,
                       encoder: JSONParameterEncoder.default).response { response in
                switch (response.result) {
                case .success:
                    LoadingIndicator.hideLoading()
                    let alert = UIAlertController(title: "등록완료", message: "정상적으로 등록되었습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "알았어요", style: .default, handler: nil))
                    self.present(alert, animated: true)
                case .failure(let error):
                    LoadingIndicator.hideLoading()
                    let alert = UIAlertController(title: "에러코드: \(error._code)", message: "에러사유: \(error.errorDescription!)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "알았어요", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            textInput.text = ""
        }
    }
    
}


