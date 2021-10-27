//
//  MainViewController.swift
//  WUPTB
//
//  Created by Moon on 2021/10/08.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var btnCurrentNation: UIButton!
    @IBOutlet weak var btnCallPolice: UIButton!
    @IBOutlet weak var btnCallHospital: UIButton!
    @IBOutlet weak var btnCallAmbassy: UIButton!
    
    var firstCallNum: String?
    var secondCallNum: String?
    var thirdCallNum: String?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let country = UserDefaults.standard.string(forKey: "nationName") else { return }
        btnCurrentNation.setTitle(country, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnShadow(btnCallPolice)
        btnShadow(btnCallHospital)
        btnShadow(btnCallAmbassy)
        firstCallNum = "01088187907"
    }
    
    func btnShadow(_ btn: UIButton){
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.masksToBounds = false
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOpacity = 0.7
    }
    
    @IBAction func btnCallTapped(_ sender: UIButton) {
        let btnTitle = sender.currentTitle
        switch btnTitle {
        case "경찰":
            btnCallTapped(firstCallNum)
        case "병원":
            btnCallTapped(secondCallNum)
        case "대사/영사관":
            btnCallTapped(thirdCallNum)
        default:
            break
        }
    }

    private func btnCallTapped(_ number: String?) {
        guard let number = number else { return }
        if let url = NSURL(string: "tel://" + "\(number)"),
           UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
}
