//
//  Content.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/13.
//

import Foundation

struct Content: Codable {
    let id: Int?
    let day: String
    let date: Int
    let content: String
    let music: String
    let emotion: Int
}
