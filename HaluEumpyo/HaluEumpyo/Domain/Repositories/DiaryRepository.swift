//
//  DiaryRepository.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/07/23.
//

import Foundation

import RxSwift

protocol DiaryRepository {
    func diaries() -> Observable<[Diary]>
}
