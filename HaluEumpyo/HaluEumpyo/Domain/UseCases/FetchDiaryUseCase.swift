//
//  FetchDiaryUseCase.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/07/23.
//

import Foundation

import RxSwift

protocol FetchDiaryUseCase {
    func diaries() -> Observable<[Diary]>
}

final class DefaultFetchDiaryUseCase: FetchDiaryUseCase {
    private let repository: DiaryRepository
    
    init(repository: DiaryRepository) {
        self.repository = repository
    }
    
    func diaries() -> Observable<[Diary]> {
        return repository.diaries()
    }
}
