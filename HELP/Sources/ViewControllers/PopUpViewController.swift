//
//  PopUpViewController.swift
//  HELP
//
//  Created by Moon on 2021/10/21.
//

import UIKit
import Alamofire

class PopUpViewController: UIViewController {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblPoliceNumber: UILabel!
    @IBOutlet weak var lblEmergencyNumber: UILabel!
    @IBOutlet weak var lblAmbassyNumber: UILabel!
    
    var nationCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgFlag.layer.borderWidth = 1.0
        imgFlag.layer.borderColor = UIColor.lightGray.cgColor
        imgFlag.layer.cornerRadius = 3.0
        getCountryDate()
    }
    
    private func getCountryDate() {
        LoadingIndicator.showLoading()
        AF.request("\(API.CountryURL)/nationInfo?nationCode=\(nationCode)", method: .get).responseJSON { response in
            do {
                let decoder = JSONDecoder()
                var nationData: Country
                switch (response.result) {
                case .success:
                    guard let value = String(data: response.data!, encoding: .utf8) else { return }
                    print(value)
                    nationData = try decoder.decode(Country.self, from: response.data!)
                    self.configureOutlets(nationData)
                    LoadingIndicator.hideLoading()
                case .failure(let error):
                    LoadingIndicator.hideLoading()
                    print("에러코드: \(error._code)")
                    print("에러사유: \(error.errorDescription!)")
                    let alert = UIAlertController(title: "오류", message: "서버와의 연결이 불안정합니다. 네트워크 환경에서 다시 시도해주세요.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            } catch let parsingError {
                print("에러:", parsingError)
            }
        }
    }
    
    private func configureOutlets(_ data: Country) {
        guard let name = data.nationName else { return }
        guard let pic = data.nationPic else { return }
        guard let police = data.policeCall else { return }
        guard let ambul = data.ambulCall else { return }
        guard let embassy = data.embassyCall else { return }

        lblName.text = name
        let img = UIImage.init(named: pic.lowercased())
        imgFlag.image = img
        lblPoliceNumber.text = police
        lblEmergencyNumber.text = ambul
        lblAmbassyNumber.text = embassy
    }
    
    @IBAction func btnSetTapped(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }

}
