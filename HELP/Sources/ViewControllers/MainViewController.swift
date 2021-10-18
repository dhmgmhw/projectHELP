//
//  MainViewController.swift
//  WUPTB
//
//  Created by Moon on 2021/10/08.
//

import UIKit

class MainViewController: UIViewController {
    
    var firstCallNum: String?
    var secondCallNum: String?
    var thirdCallNum: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        firstCallNum = "01088187907"
    }

    @IBAction func btnCallTapped(_ sender: UIButton) {
        let btnTitle = sender.currentTitle
        switch btnTitle {
        case "경찰":
            btnCallTapped(firstCallNum)
        case "병원":
            btnCallTapped(secondCallNum)
        case "대사관":
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
