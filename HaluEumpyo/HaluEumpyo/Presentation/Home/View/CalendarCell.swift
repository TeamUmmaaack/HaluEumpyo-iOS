//
//  CalendarCell.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/23.
//

import UIKit
import FSCalendar
import SwiftUI

enum FilledType: Int {
    case none
    case angry
    case hate
    case joy
    case sad
    case soso
    case fear
    case surprise
    case today
}

enum SelectedType: Int {
    case not
    case single
}

final class CalendarCell: FSCalendarCell {
    weak var emotionImageView: UIImageView!
    weak var selectionLayer: CAShapeLayer!
    
    var width: CGFloat = 32.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var yPosition: CGFloat = 2.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var filledType: FilledType = .none {
        didSet {
            setNeedsLayout()
        }
    }
    
    var selectedType: SelectedType = .not {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let emotionImageView = UIImageView()
        emotionImageView.contentMode = .scaleAspectFit
        self.contentView.insertSubview(emotionImageView, at: 0)
        self.emotionImageView = emotionImageView
        self.shapeLayer.isHidden = true
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = width
        let yPosition = yPosition
        let distance = (self.contentView.bounds.width - width) / 2
        let frame = CGRect(x: self.contentView.bounds.minX + distance + 2,
                           y: self.contentView.bounds.minY + yPosition + 2,
                           width: width,
                           height: width)
        self.emotionImageView.frame = frame
        
        switch selectedType {
        case .not:
            self.titleLabel.font = UIFont.pretendard(.regular, size: 16)
        case .single:
            self.titleLabel.font = UIFont.pretendard(.semiBold, size: 16)
        }
        
        switch filledType {
        case .angry:
            self.titleLabel.textColor = .black
            self.emotionImageView.image = ImageLiteral.imgEmotionAngry
        case .fear:
            self.titleLabel.textColor = .black
            self.emotionImageView.image = ImageLiteral.imgEmotionFear
        case .joy:
            self.titleLabel.textColor = .black
            self.emotionImageView.image = ImageLiteral.imgEmotionJoy
        case .sad:
            self.titleLabel.textColor = .black
            self.emotionImageView.image = ImageLiteral.imgEmotionSadness
        case .soso:
            self.titleLabel.textColor = .black
            self.emotionImageView.image = ImageLiteral.imgEmotionSoso
        case .surprise:
            self.titleLabel.textColor = .black
            self.emotionImageView.image = ImageLiteral.imgEmotionSurprise
        case .hate:
            self.titleLabel.textColor = .black
            self.emotionImageView.image = ImageLiteral.imgEmotionHate
        case .today:
            self.titleLabel.textColor = .haluEumpyo_purple()
            self.titleLabel.font = .pretendard(.semiBold, size: 18)
            self.emotionImageView.image = nil
        case .none:
            self.titleLabel.textColor = .black
            self.emotionImageView.image = nil
        }
    }
}
