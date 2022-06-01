//
//  DiaryService.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/05/26.
//

import Foundation

import Moya

public class DiaryService {
    static let shared = DiaryService()
    var diaryProvider = MoyaProvider<DiaryAPI>()
    
    private init() { }
    
    func getCurrentMonthDiaries(request: DiaryRequestModel, completion: @escaping (NetworkResult<Any>) -> Void) {
        diaryProvider.request(.getCurrentMonthDiaries(request: request)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, [Diary].self)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getMonthlyDiaryById(completion: @escaping(NetworkResult<Any>) -> Void) {
        diaryProvider.request(.getDiaries) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, [Diary].self)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postDiary(parameter: WriteDiaryRequestModel, completion: @escaping( NetworkResult<Any>?) -> Void) {
        diaryProvider.request(.postDiary(parameter: parameter)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, [Recommendation].self)
                print(networkResult)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ t: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GeneralResponse<T>.self, from: data)
        else { return .pathErr }
        switch statusCode {
        case 200:
            return .success(decodedData.data as Any)
        case 201..<300:
            return .success(decodedData.status as Any)
        case 400..<500:
            return .requestErr(decodedData.status as Any)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
