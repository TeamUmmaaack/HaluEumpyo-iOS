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
                let validUrlString = getYoutubeSearchUrl(withKeyword: urlString)
                print("url: \(validUrlString)")
                return validUrlString
            }
            .compactMap {
                URL(string: $0)
            }
            .compactMap {
                URLRequest(url: $0)
            }
        
        func getYoutubeSearchUrl(withKeyword keyword: String?) -> String {
            let youtubeSearchUrl = "https://www.youtube.com/results?search_query=\(keyword ?? "")"
            return youtubeSearchUrl
        }
    }
}
