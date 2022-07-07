//
//  BaseModel.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/07/07.
//

struct BaseModel<T: Decodable>: Decodable {
    var status: Int?
    var success: Bool?
    var message: String?
    var data: T?
    
    var statusCase: NetworkStatus? {
        return NetworkStatus(rawValue: status ?? 0)
    }
}

enum NetworkStatus: Int {
    case ok = 200
    case badRequest = 400
    case unAuthorized = 401
    case notFound = 404
    case internalServerError = 500
    case unknown = 0
}
