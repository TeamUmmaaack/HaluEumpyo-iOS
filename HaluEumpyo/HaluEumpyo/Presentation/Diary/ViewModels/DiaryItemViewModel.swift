//
//  DiaryItemViewModel.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/07/14.
//

import Foundation

final class DiaryItemViewModel   {
    let diary: Diary
    let locale : String
    init (with diary: Diary, locale: String) {
        self.diary = diary
        self.locale = locale
    }
    
    // MARK: - function
    
    func setDate(locale: String, date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: locale)
        dateFormatter.dateFormat = Date.FormatType.calendar.description
        let convertedDate = dateFormatter.date(from: date)
        guard let string = convertedDate?.toString(of: .day) else { return "" }
        return string
    }
}
