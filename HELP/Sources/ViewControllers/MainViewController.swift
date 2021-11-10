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
    
    var nationName: String!
    var firstCallNum: String!
    var secondCallNum: String!
    var thirdCallNum: String!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkNationData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnShadow(btnCallPolice)
        btnShadow(btnCallHospital)
        btnShadow(btnCallAmbassy)
        countryConfigure()
    }
    
    func checkNationData() {
        guard let name = UserDefaults.standard.string(forKey: "nationName") else { return }
        print(name)
        self.btnCurrentNation.setTitle(name, for: .normal)
        countryConfigure()
    }
    
    func btnShadow(_ btn: UIButton){
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.masksToBounds = false
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.layer.shadowRadius = 5
        btn.layer.shadowOpacity = 0.7
    }
    
    func countryConfigure() {
        guard let name = UserDefaults.standard.string(forKey: "nationName") else { return }
        nationName = name
        self.btnCurrentNation.setTitle(name, for: .normal)
        guard let policeNumber = UserDefaults.standard.string(forKey: "policeNumber") else { return }
        guard let emergencyNumber = UserDefaults.standard.string(forKey: "emergencyNumber") else { return }
        guard let embassyNumber = UserDefaults.standard.string(forKey: "embassyNumber") else { return }
        firstCallNum = policeNumber
        secondCallNum = emergencyNumber
        thirdCallNum = embassyNumber
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
