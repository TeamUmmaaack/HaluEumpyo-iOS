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
        $0.layer.cornerRadius = 14
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .pretendard(.medium, size: 16)
        $0.textColor = .haluEmpyo_black()
        $0.setTextWithLineHeight(text: "더 좋은 서비스를 위해\n추천받은 음악의 만족도를 평가해주세요!", lineHeight: 21)
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    private let starStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .top
        $0.distribution = .equalSpacing
        $0.spacing = 10
    }
    
    private let starSlider = UISlider().then {
        $0.value = 0
        $0.minimumValue = 0
        $0.maximumValue = 5
        $0.alpha =  0.1
        $0.tintColor = .clear
    }
    
    var starImageViews = [UIImageView]()
    
    let sendButton = UIButton().then {
        $0.isEnabled = true
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 16)
        $0.setTitleColor(UIColor.haluEumpyo_purple(), for: .normal)
        $0.addTarget(self, action: #selector(confirmButtonDidTap), for: .touchUpInside)
    }
    
    private var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.alpha = 0.8
        
        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
        return blurEffectView
    }()
    
    weak var delegate: PopUpActionProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSlider()
        initStarImageViewArray()
        view.backgroundColor = .darkGray.withAlphaComponent(0)
        blurEffectView.frame = self.view.bounds
        view.insertSubview(blurEffectView, at: 0)
    }
    
    override func configUI() {
        super.configUI()
        view.backgroundColor = UIColor.haluEumpyo_background()
    }
    
    private func initSlider() {
        starSlider.addTarget(self, action: #selector(slideStarSlider), for: UIControl.Event.valueChanged)
        starSlider.setThumbImage(UIImage(), for: .normal)
    }
    
    private func initStarImageViewArray() {
        for _ in 0..<5 {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "star.fill", withConfiguration: largeConfig)
            imageView.contentMode = .scaleToFill
            imageView.tintColor = UIColor.lightGray
            starImageViews.append((imageView))
            self.starStackView.addArrangedSubview(imageView)
        }
    }
    
    // 빈 별
    private func showStarImageEmpty(imageView: UIImageView) {
        imageView.tintColor = .lightGray
    }
    
    // 반 채워진 별
    private func showStarImageHalf(imageView: UIImageView) {
        imageView.tintColor = .blue
    }
    
    // 다 채워진 별
    private func showStarImageFull(imageView: UIImageView) {
        imageView.tintColor = .haluEumpyo_purple()
    }
    
    @objc func slideStarSlider() {
        var value = starSlider.value
        var values: [Double] = [0, 0, 0, 0, 0]
        var rating: Double = 0
        
        for idx in 0..<5 {
            if value > 0.5 {
                value -= 1
                values[idx] = 1
                showStarImageFull(imageView: starImageViews[idx])
            } else {
                values[idx] = 0
                showStarImageEmpty(imageView: starImageViews[idx])
            }
            print(values[idx])
        }
        
        for idx in 0..<5 {
            rating += values[idx]
        }
    }
    
    override func setUpLayoutConstraint() {
        view.addSubview(containerView)
        containerView.addSubviews([titleLabel, starStackView, starSlider, sendButton])
        
        containerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(266)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerX.equalToSuperview()
        }
        
        starStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.width.equalTo(244)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(starSlider)
        }
        
        starSlider.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.centerX.equalTo(starStackView)
            $0.centerY.equalTo(starStackView)
            $0.width.equalTo(starStackView)
            $0.height.equalTo(50)
        }
        
        sendButton.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(28)
        }
    }
    
    @objc
    func confirmButtonDidTap() {
        delegate?.confirmButtonDidTap(sendButton)
    }
}
