//
//  HomeViewController+Network.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/05/26.
//

import UIKit

extension HomeViewController {
    
    public func getDiaries() {
        DiaryService.shared.getMonthlyDiaryById { [weak self] response in
            switch response {
            case .success(let data):
                guard let data = data as? [Diary] else { return }
                self?.scheduleItems = data
                self?.parseSchedules()
            case .requestErr(let message):
                print("requesterr \(message)")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("pathErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    public func parseSchedules() {        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.FormatType.calendar.description
        dateFormatter.locale = Locale(identifier:"ko_KR")
        let items = scheduleItems.map { [dateFormatter.date(from: $0.createdAt) as Any, $0.emotionID ?? 7] }
        
        for (index, item) in items.enumerated() {
            guard let scheduleDate = item[0] as? Date else { return }
            guard let emotion = item[1] as? Int else { return }
            
            if emotion == 1 {
                let key = Attributes(date: scheduleDate.toString(of: .year), emotion: .joy)
                newItems.updateValue(scheduleItems[index], forKey: key)
                joyList.append(scheduleDate.toString(of: .year))
            } else if emotion == 2 {
                let key = Attributes(date: scheduleDate.toString(of: .year), emotion: .sadness)
                newItems.updateValue(scheduleItems[index], forKey: key)
                sadList.append(scheduleDate.toString(of: .year))
            } else if emotion == 4 {
                let key = Attributes(date: scheduleDate.toString(of: .year), emotion: .angry)
                newItems.updateValue(scheduleItems[index], forKey: key)
                angryList.append(scheduleDate.toString(of: .year))
            } else if emotion == 7 {
                let key = Attributes(date: scheduleDate.toString(of: .year), emotion: .soso)
                newItems.updateValue(scheduleItems[index], forKey: key)
                sosoList.append(scheduleDate.toString(of: .year))
            }
        }
    }
}
