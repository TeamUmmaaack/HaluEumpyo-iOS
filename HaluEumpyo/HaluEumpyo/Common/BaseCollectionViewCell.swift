//
//  BaseCollectionViewCell.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/11.
//

import UIKit

import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setUpLayoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        // View Configuration
    }
    
    func setUpLayoutConstraint() {
        // set up layout
    }
}
