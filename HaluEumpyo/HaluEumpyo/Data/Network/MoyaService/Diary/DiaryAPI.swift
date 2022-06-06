//
//  DiaryAPI.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/05/26.
//

import Foundation

import Moya

enum DiaryAPI {
    case getCurrentMonthDiaries(request: DiaryRequestModel)
    case getDiaries
    case postDiary(parameter: WriteDiaryRequestModel)
}

extension DiaryAPI: BaseTargetType {
    typealias ResultModel = Diary
    
    var path: String {
        switch self {
        case .getCurrentMonthDiaries:
            return "\(URLConstant.GET.monthCalendar)"
        case .getDiaries:
            return "\(URLConstant.GET.calendar)"
        case .postDiary:
            return URLConstant.POST.diary
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCurrentMonthDiaries, .getDiaries:
            return .get
        case .postDiary:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getCurrentMonthDiaries(let request):
            return .requestParameters(parameters: ["date": request.date], 
                                      encoding: URLEncoding.queryString)
        case .getDiaries:
            return .requestPlain
        case .postDiary(let parameter):
            return .requestParameters(parameters: ["content": parameter.content],
                                      encoding: JSONEncoding.default)
        }
    }
}
