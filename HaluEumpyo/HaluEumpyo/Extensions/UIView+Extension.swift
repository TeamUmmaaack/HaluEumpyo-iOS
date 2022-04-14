//
//  UIView+Extension.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/11.
//

import Foundation

import UIKit

extension UIView {
    enum DashedOrientation {
        case horizontal
        case vertical
    }
    
    func makeDashedBorderLine(color: UIColor, strokeLength: NSNumber, gapLength: NSNumber, width: CGFloat, orientation: DashedOrientation) {
        let path = CGMutablePath()
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = width
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineDashPattern = [strokeLength, gapLength]
        if orientation == .vertical {
            path.addLines(between: [CGPoint(x: bounds.midX, y: bounds.minY),
                                    CGPoint(x: bounds.midX, y: bounds.maxY)])
        } else if orientation == .horizontal {
            path.addLines(between: [CGPoint(x: bounds.minX, y: bounds.midY),
                                    CGPoint(x: bounds.maxX, y: bounds.midY)])
        }
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    func createDottedLine(width: CGFloat, color: CGColor) {
       let caShapeLayer = CAShapeLayer()
       caShapeLayer.strokeColor = color
       caShapeLayer.lineWidth = width
       caShapeLayer.lineDashPattern = [2,3]
       let cgPath = CGMutablePath()
       let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: self.frame.width)]
       cgPath.addLines(between: cgPoint)
       caShapeLayer.path = cgPath
       layer.addSublayer(caShapeLayer)
    }
    
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
    
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
