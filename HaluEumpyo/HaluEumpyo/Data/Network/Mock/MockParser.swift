//
//  MockParser.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/07/07.
//

import Foundation

final class MockParser {
    static func load<T: Decodable>(_ type: T.Type, from resourceName: String) -> BaseModel<T>? {
        // type: 디코딩 할 때 사용되는 모델의 타입
        // resourceName: json 파일 네임
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "json") else {
                    return nil
        }
        let fileURL = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: fileURL) else {
            return nil
        }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            return nil
        }
        guard let decodable = try? JSONSerialization.data(withJSONObject: jsonObject) else { return nil }
        return try? JSONDecoder().decode(BaseModel<T>.self, from: decodable)
    }
}
