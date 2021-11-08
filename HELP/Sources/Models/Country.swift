//
//  Country.swift
//  HELP
//
//  Created by Moon on 2021/10/12.
//

import Foundation

struct NationElement: Codable {
    let nationCode, nationName, nationPic: String

    enum CodingKeys: String, CodingKey {
        case nationCode = "nation_code"
        case nationName = "nation_name"
        case nationPic = "nation_pic"
    }
}

typealias Nation = [NationElement]

struct Country: Codable {
    let nationCode,
        nationName,
        embassyName,
        embassyLOC,
        embassyAdress,
        embassyCall,
        embassyCall2,
        embassyCall3,
        embassyECall,
        embassyECall2,
        embassyECall3,
        policeCall,
        ambulCall,
        fireCall,
        embassyEtc,
        nationPic: String?

    enum CodingKeys: String, CodingKey {
        case nationCode = "nation_code"
        case nationName = "nation_name"
        case embassyName = "embassy_name"
        case embassyLOC = "embassy_loc"
        case embassyAdress = "embassy_adress"
        case embassyCall = "embassy_call"
        case embassyCall2 = "embassy_call2"
        case embassyCall3 = "embassy_call3"
        case embassyECall = "embassy_e_call"
        case embassyECall2 = "embassy_e_call2"
        case embassyECall3 = "embassy_e_call3"
        case policeCall = "police_call"
        case ambulCall = "ambul_call"
        case fireCall = "fire_call"
        case embassyEtc = "embassy_etc"
        case nationPic = "nation_pic"
    }
}
