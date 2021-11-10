//
//  TabBarController.swift
//  HELP
//
//  Created by Moon on 2021/10/19.
//

import UIKit

class BaseTabBarController: UITabBarController {
    @IBInspectable var defaultIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        let nationData = UserDefaults.standard.string(forKey: "nationName")
        if nationData != nil {
            defaultIndex = 1
            selectedIndex = defaultIndex
            return
        }
        
        UserDefaults.standard.set("대한민국", forKey: "nationName")
        UserDefaults.standard.set("112", forKey: "policeNumber")
        UserDefaults.standard.set("119", forKey: "emergencyNumber")
        UserDefaults.standard.set("0232100404", forKey: "embassyNumber")
        UserDefaults.standard.set("외교부 영사민원실", forKey: "embassyName")
        UserDefaults.standard.set("37.483451074521504, 127.02932081899209", forKey: "embassyAddress")
        selectedIndex = defaultIndex
    }
}
