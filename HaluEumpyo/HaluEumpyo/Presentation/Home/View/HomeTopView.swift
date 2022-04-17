//
//  HomeTopView.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/12.
//

import UIKit

import SnapKit

final class HomeTopView: UIView {    
    // MARK: - Property
    let leftButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 28, height: 28)))
        button.setImage(UIImage(named: "btn_archivebox"), for: .normal)
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 28, height: 28)))
        button.setImage(UIImage(named: "btn_setting"), for: .normal)
        return button
    }()
    
    deinit {
        print("deinit : \(self)")
    }
   
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
