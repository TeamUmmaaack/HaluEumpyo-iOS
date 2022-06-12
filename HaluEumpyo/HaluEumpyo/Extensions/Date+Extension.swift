//
//  Date+Extension.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/11.
//

import Foundation

import Then

enum DateFormat: String {
    case format1 = "yyyy-MM-dd"
    case format2 = "dd(EE)"
    case format3 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
}

extension Date {
    enum FormatType {
        case full
        case year
        case day
        case month
        case second
        case time
        case calendar
        case calendarTime
        
        var description: String {
            switch self {
            case .full:
                return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
            case .year:
                return "yyyy-MM-dd"
            case .day:
                return "yyyy년 M월 d일-EEEE"
            case .month:
                return "M월"
            case .second:
                return "HH:mm:ss"
            case .time:
                return "a h:mm"
            case .calendar:
                return "yyyy-MM-dd EEEEE HH:mm"
            case .calendarTime:
                return "a HH:mm"
            }
        }
    }
    
    func toString(of type: FormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = type.description
        return dateFormatter.string(from: self)
    }
    
    func toEngString(of type: FormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = type.description
        return dateFormatter.string(from: self)
    }

    func formatter(_ format: DateFormat) -> DateFormatter {
        return DateFormatter().then {
            $0.dateFormat = format.rawValue
            $0.locale = Locale(identifier: "ko_KR")
        }
    }
    
    var toStringTypeOne: String {
        return formatter(.format1).string(from: self)
    }
    
    var toStringTypeTwo: String {
        return formatter(.format2).string(from: self)
    }
    
    var toStringTypeThree: String {
        return formatter(.format3).string(from: self)
    }
}
