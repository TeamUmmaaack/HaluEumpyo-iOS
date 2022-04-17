//
//  WriteDiaryTopView.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/16.
//

import UIKit

import SnapKit

class WriteDiaryTopView: UIView {
    // MARK: - Property
    
    let leftButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 28, height: 28)))
        button.setImage(ImageLiteral.btnClose, for: .normal)
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 28, height: 28)))
        button.setImage(ImageLiteral.btnSend, for: .normal)
        return button
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpLayoutConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayoutConstraint() {
        addSubview(leftButton)
        addSubview(rightButton)
        
        leftButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(17)
            $0.bottom.equalToSuperview().inset(5)
        }
        
        rightButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(5)
        }
    }
}
