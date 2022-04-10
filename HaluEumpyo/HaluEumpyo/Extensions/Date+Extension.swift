//
//  Date+Extension.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/11.
//

import Foundation

import Then

enum DateFormat: String {
    case format1 = "yyyy.MM.dd(EE)"
    case format2 = "dd(EE)"
}

extension Date {
    func formatter(_ format: DateFormat) -> DateFormatter {
        return DateFormatter().then {
            $0.dateFormat = format.rawValue
            $0.locale = Locale(identifier: "eng")
        }
    }
    
    var toStringTypeOne: String {
        return formatter(.format1).string(from: self)
    }
    
    var toStringTypeTwo: String {
        return formatter(.format2).string(from: self)
    }
}
