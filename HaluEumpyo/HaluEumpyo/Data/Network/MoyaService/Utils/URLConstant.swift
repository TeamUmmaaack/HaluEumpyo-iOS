//
//  URLConstant.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/05/26.
//

import Foundation

enum URLConstant {
    static let baseURL = "https://asia-northeast3-haluempyo.cloudfunctions.net/api/"
    
    static let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjEsImVtYWlsIjoidGVzdGVtYWlsMUBnbWFpbC5jb20iLCJpZEZpcmViYXNlIjoiYTM0SEduSXRQbmFCUllxOUkyNFhZTGZmWnhFMiIsImlhdCI6MTY1NDAyNjM1MCwiZXhwIjoxNjU1MjM1OTUwLCJpc3MiOiJoYWx1ZXVtcHlvIn0._7FH9kiGcfsyuvdAmHfbs29vm3SVOZTjvtkIYVRKuWU"
    
    struct GET {
        static let calendar = "/calendar"
        static let monthCalendar = "/calendar/detail"
    }
    
    struct POST {
        static let diary = "/diary"
    }
}
