//
//  MainViewController.swift
//  WUPTB
//
//  Created by Moon on 2021/10/08.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var btnFirstCall: UIButton!
    
    var firstCallNum: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstCallNum = "01088187907"
    }

    @IBAction func btnFirstCallTapped(_ sender: UIButton) {
        btnCallTapped(firstCallNum)
    }

    private func btnCallTapped(_ number: String?) {
        guard let number = number else { return }
        if let url = NSURL(string: "tel://" + "\(number)"),
           UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }

}
