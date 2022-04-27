//
//  Diary.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/23.
//

import Foundation

struct DiaryLists: Codable {
    let id: Int?
    let emotion: Int
    let diaryContents: [Diary]
}

struct Diary: Codable {
    let date: String
    let weekOfDate: String
    let content: String
    let music: String
}
