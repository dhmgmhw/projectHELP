//
//  PopUpViewController.swift
//  HELP
//
//  Created by Moon on 2021/10/21.
//

import UIKit

class PopUpViewController: UIViewController {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblPoliceNumber: UILabel!
    @IBOutlet weak var lblEmergencyNumber: UILabel!
    @IBOutlet weak var lblAmbassyNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnSetTapped(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }

}
