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
        UserDefaults.standard.set("서울특별시 서초구 남부순환로 2558 외교타운 6층 외교부 영사민원실", forKey: "embassyAddress")
        selectedIndex = defaultIndex
    }
}
