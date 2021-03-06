//
//  WebViewModel.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/17.
//

import Foundation

import RxSwift

final class WebViewModel {

    let urlString: BehaviorSubject<String?>
    var urlRequest: Observable<URLRequest>
    
    // MARK: - init
    
    init(urlString: String) {
        self.urlString = BehaviorSubject<String?>(value: urlString)
     
        self.urlRequest = self.urlString
            .compactMap { urlString -> String? in
                return urlString
            }
            .compactMap {
                URL(string: $0)
            }
            .compactMap {
                URLRequest(url: $0)
            }
        
        func getYoutubeSearchUrl(withKeyword keyword: String?) -> String? {
            let youtubeSearchUrl = "\(keyword ?? "")"
            return youtubeSearchUrl
        }
    }
}
