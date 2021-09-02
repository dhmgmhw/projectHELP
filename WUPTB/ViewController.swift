//
//  ViewController.swift
//  WUPTB
//
//  Created by Moon on 2021/09/01.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgBtn: UIImageView!
    @IBOutlet weak var lblPressCount: UILabel!
    @IBOutlet weak var lblEarnedMoney: UILabel!
        
    var pressCount: Int = 0
    var earnedMoneny: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lblPressCount.text = "\(pressCount) people"
        lblEarnedMoney.text = "$\(earnedMoneny)"
    }

    @IBAction func btnPressing(_ sender: Any) {
        imgBtn.image = UIImage(named: "pressed")
    }
    
    @IBAction func btnPressed(_ sender: Any) {
        imgBtn.image = UIImage(named: "unpressed")
        
        pressCount = pressCount + 1
        lblPressCount.text = "\(pressCount) people"
        
        earnedMoneny = earnedMoneny + 10000
        lblEarnedMoney.text = "$\(earnedMoneny)"
    }
    
}

