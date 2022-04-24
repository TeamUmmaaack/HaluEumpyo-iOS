//
//  HEButton.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/24.
//

import UIKit

class HEButton: UIButton {
    private let buttonBackgroundImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = ImageLiteral.btnMove
    }
    
    let listenButton: UIButton = {
        let button = UIButton()
        if #available(iOS 15.0, *) {
            let container = AttributeContainer([.font: UIFont.pretendard(size: 15), .foregroundColor: UIColor.white])
            var configuration = UIButton.Configuration.plain()
            configuration.attributedTitle = AttributedString("들으러 가기", attributes: container)
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 0, bottom: 20, trailing: 0)
            configuration.image = ImageLiteral.icPlay
            configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 10)
            configuration.imagePadding = 4
            button.configuration = configuration
        } else {
            let button = UIButton()
            button.setImage(ImageLiteral.icPlay, for: .normal)
            button.setTitle("들으러 가기", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        return button
    }()
    
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
        addSubview(buttonBackgroundImageView)
        buttonBackgroundImageView.addSubview(listenButton)
        
        buttonBackgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        listenButton.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
