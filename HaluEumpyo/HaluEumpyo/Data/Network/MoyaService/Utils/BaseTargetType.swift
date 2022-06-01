//
//  BaseTargetType.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/05/26.
//

import Moya

protocol BaseTargetType: TargetType {
}

extension BaseTargetType {
    var baseURL: URL {
        return URL(string: URLConstant.baseURL)!
    }
    
    var headers: [String: String]? {
        let header = [
            "Content-Type": "application/json",
            "x-access-token": URLConstant.token]
        return header
    }
    
    var sampleData: Data {
        return Data()
    }
}
