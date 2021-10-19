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
        }
        selectedIndex = defaultIndex
    }
}
