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

struct Nation: Codable {
    let nationCode: String
    let nationName: String
    let policeCall: String
    let fireCall: String
    let embassyCall: String
    let embassyLoc: String
    
    enum CodingKeys: String, CodingKey {
        case nationCode = "nation_code"
        case nationName = "nation_name"
        case policeCall = "police_call"
        case fireCall = "fire_call"
        case embassyCall = "embassy_call"
        case embassyLoc = "embassy_loc"
    }
}




public var countries = [
    ["nationalCode":"KR", "name":"대한민국"],
    ["nationalCode":"AU", "name":"호주"],
    ["nationalCode":"CA", "name":"캐나다"],
    ["nationalCode":"CN", "name":"중국"],
    ["nationalCode":"DE", "name":"독일"],
    ["nationalCode":"GB", "name":"영국"],
    ["nationalCode":"HK", "name":"홍콩"],
    ["nationalCode":"ID", "name":"인도네시아"],
    ["nationalCode":"JP", "name":"일본"],
    ["nationalCode":"MY", "name":"말레이시아"],
    ["nationalCode":"PH", "name":"필리핀"],
    ["nationalCode":"SG", "name":"싱가포르"],
    ["nationalCode":"TH", "name":"태국"],
    ["nationalCode":"TW", "name":"타이완"],
    ["nationalCode":"US", "name":"미국"],
    ["nationalCode":"VN", "name":"베트남"],
]

