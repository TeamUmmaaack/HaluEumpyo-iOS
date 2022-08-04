//
//  DiaryMockRepository.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/07/24.
//

import Foundation

import RxSwift
import Moya

class DiaryMockRepository: DiaryRepository {
    func diaries() -> Observable<[Diary]> {
        let observable = Observable<[Diary]>.create { observer -> Disposable in
            let resourceName = "entire_diary"
            var data: Data
            guard let path = Bundle.main.path(forResource: resourceName, ofType: "json") else {
                fatalError("Could not find \(resourceName) in main bundle!")
            }
            let fileURL = URL(fileURLWithPath: path)
            guard let data = try? Data(contentsOf: fileURL) else {
                fatalError("Could not read \(resourceName) from main bundle!")
            }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
                fatalError("Could not read \(resourceName) from main bundle!")
            }
            guard let decodable = try? JSONSerialization.data(withJSONObject: jsonObject) else { fatalError("Couldn't parse \(resourceName) as \([Diary].self)") }
            do {
                let decoder = JSONDecoder()
                guard let decodedData = try? decoder.decode(GeneralResponse<[Diary]>.self, from: decodable) else {
                    fatalError("Could not read \(resourceName) from main bundle!")
                }
                observer.onNext(decodedData.data!)
                observer.onCompleted()
            } catch {
                fatalError("Couldn't parse \(resourceName) as \([Diary].self)")
            }
            return Disposables.create()
        }
        return observable
    }
}
