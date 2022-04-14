//
//  CALayer+Extensions.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/14.
//

import UIKit

extension CALayer {
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.1,
        x: CGFloat = 0,
        y: CGFloat = 0,
        blur: CGFloat = 8,
        spread: CGFloat = 0
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 1.0
    }
}
