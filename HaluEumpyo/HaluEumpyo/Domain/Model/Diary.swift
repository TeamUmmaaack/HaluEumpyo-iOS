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

struct DiaryContents: Codable {
    let data: [Diary]
}

struct Diary: Codable {
    let id: Int
    let content: String
    let musicID: Int?
    let emotionID: Int?
    let title: String
    let singer: String
    let cover: String
    let url: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, content, createdAt, title, singer, cover, url
        case musicID = "musicId"
        case emotionID = "emotionId"
    }
}
