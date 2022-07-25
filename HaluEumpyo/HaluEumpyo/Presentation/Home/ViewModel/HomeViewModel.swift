//
//  HomeViewModel.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/05/26.
//

import Foundation

import RxSwift
import RxCocoa
import Moya

final class HomeViewModel {
    private let diaryUseCase: FetchDiaryUseCase
    
    struct Input {
        let viewWillAppear: Observable<Void>
    }
    
    struct Output {
        let diary: Driver<[Diary]>
    }
    
    init(diaryUseCase: FetchDiaryUseCase) {
        self.diaryUseCase = diaryUseCase
    }
    
    func transform(input: Input) -> Output {
        let diary = input.viewWillAppear.flatMap {
            return self.diaryUseCase.diaries()
        }
        
        return Output(diary: diary)
    }
    
}
