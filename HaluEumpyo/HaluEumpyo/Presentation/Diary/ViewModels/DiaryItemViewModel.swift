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
}
