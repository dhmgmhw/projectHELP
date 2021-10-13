//
//  Country.swift
//  HELP
//
//  Created by Moon on 2021/10/12.
//

import Foundation

struct Country: Codable {
    let id: String
    let name: String
}

//struct Country: Codable {
//    let name: String?
//    let numOfPolice: String?
//    let numOfEmergency: String?
//    let numOfEmbassy: String?
//    let addressOfEmbassy: String?
//    let imgFlag: String?
//}

enum Countries {
    case KR
}
