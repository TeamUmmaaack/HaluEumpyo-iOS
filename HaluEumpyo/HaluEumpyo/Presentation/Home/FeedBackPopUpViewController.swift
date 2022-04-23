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
    
    private let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 16)
        $0.setTitleColor(UIColor.lightGray, for: .normal)
        $0.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
    }
    
    let sendButton = UIButton().then {
        $0.isEnabled = false
        $0.setTitle("피드백 보내기", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 16)
        $0.setTitleColor(UIColor.haluEumpyo_purple(), for: .normal)
        $0.setTitleColor(UIColor.gray003(), for: .disabled)
        $0.addTarget(self, action: #selector(confirmButtonDidTap), for: .touchUpInside)
    }
    
    weak var delegate: PopUpActionProtocol?
    var rateButtonList: [UIButton] = []
    var starRate = BehaviorSubject<Int>(value: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configUI() {
        super.configUI()
        view.backgroundColor = UIColor.haluEumpyo_background()
    }
    
    override func setUpLayoutConstraint() {
        view.addSubview(containerView)
        containerView.addSubviews([titleLabel, rateStackView, cancelButton, sendButton])
        
        for index in 1...5 {
            let button = HERateButton(type: .rate)
            button.setTitle("\(index)", for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(self.setAction(sender:)), for: .touchUpInside)
            rateButtonList.append((button))
            self.rateStackView.addArrangedSubview(button)
        }
        
        containerView.snp.makeConstraints {
            $0.width.equalTo(320)
            $0.height.equalTo(428)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        rateStackView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        cancelButton.snp.makeConstraints {
            $0.width.equalTo(160)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(28)
        }
        
        sendButton.snp.makeConstraints {
            $0.width.equalTo(160)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(28)
        }
    }
    
    @objc
    private func setAction(sender: UIButton) {
        let ratingScore = sender.tag
        print(ratingScore)
        rateButtonList.enumerated().forEach {
            $1.isSelected = ratingScore == $0 + 1 ? true : false
        }
        starRate.onNext(ratingScore)
    }
    
    @objc
    func cancelButtonDidTap() {
        delegate?.cancelButtonDidTap(cancelButton)
    }
    
    @objc
    func confirmButtonDidTap() {
        delegate?.confirmButtonDidTap(sendButton)
    }
}
