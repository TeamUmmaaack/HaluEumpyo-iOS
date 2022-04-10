//
//  UIView+Extension.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/11.
//

import Foundation

import UIKit

extension UIView {
    func applyZeplinShadow (color: UIColor = .black,
                            alpha: Float,
                            x: CGFloat,
                            y: CGFloat,
                            blur: CGFloat,
                            spread: CGFloat) -> Self {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2.0
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
        return self
    }
}
