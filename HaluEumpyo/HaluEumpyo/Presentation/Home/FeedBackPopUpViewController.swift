//
//  FeedBackPopUpViewController.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/21.
//

import UIKit

import RxSwift

final class FeedBackPopUpViewController: BaseViewController {
    
    // MARK: - Property
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .pretendard(size: 14)
        $0.textColor = .haluEmpyo_black()
        $0.text = "음악 평가는 어떘나요? 솔직한 평가를 들려주세요"
    }
    
    private let rateStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configUI() {
        super.configUI()
    }
}
