//
//  CountryCell.swift
//  HELP
//
//  Created by Moon on 2021/10/12.
//

import UIKit

class CountryCell: UITableViewCell {
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblCountry: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
