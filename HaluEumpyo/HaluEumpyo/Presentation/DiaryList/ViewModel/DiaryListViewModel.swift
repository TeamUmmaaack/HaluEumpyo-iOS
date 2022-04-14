//
//  DiaryListViewModel.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/14.
//

import Foundation

import RxSwift
import RxCocoa

final class DiaryListViewModel {
    struct Input {
        let viewWillAppearEvent: Observable<Void>
        let content: Observable<[Content]>
        let datePickerControlEvent: ControlEvent<Void>
    }
    
    struct Output {
        
    }
    
    var diaryContentListRelay = BehaviorRelay<[Content]>(value: [
        Content(id: 1,
                day: "WED",
                date: 2,
                content: "과제 제출이 어제까지였다 망했다...ㅋㅋㅋㅋㅋㅋ 기분완전 꿀꿀하다",
                music: "Bring me the horizon -Doomed",
                emotion: 3
                ),
        Content(id: 2,
                day: "SAT",
                date: 5,
                content: "새벽 1시에 봤다...ㅎ 엄마랑 같이 자야지 진짜 무섭네",
                music: "Michael Jackson - Thriller",
                emotion: 5),
        Content(id: 3,
                day: "Tue",
                date: 8,
                content: "으으으 바퀴벌레 봤다 기분나빠 ",
                music: "HALSEY - I HATE EVERYTHING",
                emotion: 4),
        Content(id: 4,
                day: "THUR",
                date: 10,
                content: "그저 그런 하루였다 뭔가 특별한 것도 없었고...",
                music: "Supertramp - Just A Normal Day",
                emotion: 6),
        Content(id: 5,
                day: "FRI",
                date: 11,
                content: "포켓몬빵 드디어 샀다 ㅋㅋ 편의점 다섯 군데 돌았는데 초딩...",
                music: "Charlie Pooth - See You Again",
                emotion: 0)
    ])
    
    // MARK: - Private
    
    private func load() {
        
    }
    
    
}
