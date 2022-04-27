//
//  HERateButton.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/22.
//

import UIKit

class HERateButton: UIButton {
    
    enum Style {
        case day
        case rate
    }
    
    override var isSelected: Bool {
        didSet {
            setSelectedState()
        }
    }
    
    var type: Style?
    
    public init(type: Style?) {
        self.type = type
        super.init(frame: .zero)
        setInitialState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setInitialState() {
        backgroundColor = .white
        setTitleColor(UIColor.gray001(), for: .normal)
        titleLabel?.font = .pretendard(size: 14)
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray003().cgColor
    }
    
    private func setSelectedState() {
        guard let type = self.type else { return }
        var selectedColor: UIColor
        
        switch type {
        case .day:
            selectedColor = UIColor.gray002()
        case .rate:
            selectedColor = UIColor.haluEumpyo_purple()
        }
        
        if isSelected {
            backgroundColor = selectedColor
            layer.borderColor = UIColor.clear.cgColor
            setTitleColor(.white, for: .normal)
            titleLabel?.font = .pretendard(size: 16)
        } else {
            backgroundColor = .white
            layer.borderColor = UIColor.lightGray.cgColor
            setTitleColor(UIColor.gray003(), for: .normal)
            titleLabel?.font = .pretendard(size: 2)
        }
    }
}
