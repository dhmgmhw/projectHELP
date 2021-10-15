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

var countries = [
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
