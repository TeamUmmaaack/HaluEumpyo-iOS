//
//  UIFont+Extension.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/11.
//

import Foundation

import UIKit

extension UIFont {
    enum FontFamily: String {
        case bold = "Pretendard-Bold"
        case semiBold = "Pretendard-SemiBold"
        case regular = "Pretendard-Regular"
        case medium = "Pretendard-Medium"
        case light = "Pretendard-Light"
    }

    static func pretendard(_ family: FontFamily = .medium, size: CGFloat) -> UIFont {
        return UIFont(name: family.rawValue, size: size)!
    }
}
