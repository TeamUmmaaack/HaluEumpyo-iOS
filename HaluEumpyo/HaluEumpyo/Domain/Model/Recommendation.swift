//
//  Recommendation.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/05/27.
//

import Foundation

struct Recommendation: Codable {
    let title, singer: String
     let cover: String
     let url: String
     let emotionID: Int

     enum CodingKeys: String, CodingKey {
         case title, singer, cover, url
         case emotionID = "emotionId"
     }
}
    
