//
//  CustomActivityIndicator.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/18.
//

import UIKit

class CustomActivityIndicator: UIView {
    static var shared = CustomActivityIndicator()
    private convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    
    private var spinnerBehavior: UIDynamicItemBehavior?
    private var animator: UIDynamicAnimator?
    private var imageView: UIImageView?
    private var loaderImageName = ""
    
    private var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.alpha = 0.8
        
        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
        return blurEffectView
    }()
    
    private let popUpView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "분석중..."
        $0.textAlignment = .center
        $0.textColor = .haluEumpyo_purple()
        $0.font = .pretendard(.bold, size: 20)
    }
    
    private let subtitleLabel = UILabel().then {
        $0.setTextWithLineHeight(text: "오늘의 기분에 어울리는 노래를\n찾아 드릴게요!", lineHeight: 21)
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.textColor = .gray003()
        $0.font = .pretendard(.regular, size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray.withAlphaComponent(0)
        blurEffectView.frame = self.bounds
        insertSubview(blurEffectView, at: 0)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(with image: String = "img_modal_circle") {
        loaderImageName = image
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {[weak self] in
            if self?.imageView == nil {
                self?.setupView()
                DispatchQueue.main.async {[weak self] in
                    self?.showLoadingActivity()
                }
            }
        }
    }
    
    func hide() {
        DispatchQueue.main.async {[weak self] in
            self?.stopAnimation()
        }
    }
    
    private func setupView() {
        addSubview(popUpView)
        center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
        
        let theImage = UIImage(named: loaderImageName)
        imageView = UIImageView(image: theImage)
        imageView?.backgroundColor = .white
        popUpView.frame = CGRect(x: self.center.x - 130, y: self.center.y - 133, width: 250, height: 266)
        imageView?.frame = CGRect(x: self.center.x - 52, y: self.center.y - 86, width: 93, height: 93)
        
        if let imageView = imageView {
            self.spinnerBehavior = UIDynamicItemBehavior(items: [imageView])
        }
        animator = UIDynamicAnimator(referenceView: self)
    }
    
    private func showLoadingActivity() {
        if let imageView = imageView {
            addSubview(imageView)
            popUpView.addSubviews([titleLabel, subtitleLabel])
            
            titleLabel.snp.makeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(14)
                $0.centerX.equalToSuperview()
            }
            
            subtitleLabel.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(5)
                $0.centerX.equalToSuperview()
            }
            startAnimation()
            UIApplication.shared.windows.first?.addSubview(self)
            self.isUserInteractionEnabled = false
        }
    }
    
    private func startAnimation() {
        guard let imageView = imageView,
              let spinnerBehavior = spinnerBehavior,
              let animator = animator else { return }
        if !animator.behaviors.contains(spinnerBehavior) {
            spinnerBehavior.addAngularVelocity(5.0, for: imageView)
            animator.addBehavior(spinnerBehavior)
        }
    }
    
    private func stopAnimation() {
        animator?.removeAllBehaviors()
        imageView?.removeFromSuperview()
        imageView = nil
        self.removeFromSuperview()
        self.isUserInteractionEnabled = true
    }
}
