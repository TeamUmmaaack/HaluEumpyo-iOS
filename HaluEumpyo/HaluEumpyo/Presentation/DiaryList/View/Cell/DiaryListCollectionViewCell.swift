//
//  DiaryListCollectionViewCell.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/12.
//

import Foundation
import UIKit

class DiaryListCollectionViewCell: BaseCollectionViewCell {
    // MARK: - Property
    private var contentId: Int?
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let dateContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(size: 20)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "11"
        return label
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(size: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "MAR"
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.medium, size: 14)
        label.textColor = UIColor.gray001()
        label.numberOfLines = 2
        label.text = "포켓몬빵 드디어 샀다 ㅋㅋ 편의점 다섯 군데 돌았는데 초딩들이 다 들고가서 없었다. 근데 마지막에서 찾았지 앗싸 신난다~"
        return label
    }()
    
    private let recommendedSongLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.medium, size: 12)
        label.textColor = UIColor.gray001()
        label.text = "Wiz Califa - See You Again"
        return label
    }()
    
    private let noteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.imgEmotionJoy
        return imageView
    }()
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray003()
        return view
    }()
    
    private let vStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.alignment = .center
        stack.distribution = .fillEqually

        return stack
    }()
    
    override func prepareForReuse() {
        backgroundColor = .white
        noteImageView.image = nil
        dateLabel.text = ""
        dayLabel.text = ""
        contentLabel.text = ""
        recommendedSongLabel.text = ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        seperatorView.makeDashedBorderLine(color: .gray003(), strokeLength: 5, gapLength: 2, width: 1, orientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUpLayoutConstraint() {
        contentView.addSubviews([containerView, vStackView, seperatorView, contentContainerView])

        contentContainerView.addSubviews([contentLabel, recommendedSongLabel, noteImageView])
        
        vStackView.addArrangedSubview(dateLabel)
        vStackView.addArrangedSubview(dayLabel)
        
        containerView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        vStackView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(20)
            $0.leading.equalTo(contentView).offset(12)
            $0.bottom.equalTo(contentView).inset(18)
            $0.width.equalTo(73)
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.bottom.equalTo(contentView)
            $0.leading.equalTo(vStackView.snp.trailing).offset(10)
            $0.width.equalTo(1)
        }
        
        contentContainerView.snp.makeConstraints {
            $0.top.bottom.equalTo(contentView)
            $0.leading.equalTo(seperatorView.snp.trailing)
            $0.trailing.equalTo(contentView)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(12)
            $0.leading.equalTo(contentContainerView.snp.leading).offset(12)
            $0.trailing.equalTo(contentView).offset(-12)
        }
        
        recommendedSongLabel.snp.makeConstraints {
            $0.bottom.equalTo(contentView).inset(12)
            $0.leading.equalTo(contentContainerView.snp.leading).offset(12)
            $0.trailing.equalTo(noteImageView.snp.leading).offset(12)
        }
        
        noteImageView.snp.makeConstraints {
            $0.trailing.equalTo(contentView).inset(12)
            $0.bottom.equalTo(contentView).inset(12)
            $0.width.equalTo(10)
            $0.height.equalTo(17)
        }
    }
    
    func setData(content: Content) {
        contentId = content.id
        noteImageView.image = ImageLiteral.imgEmotionJoy
        dateLabel.text = "\(content.date)"
        dayLabel.text = content.day
        contentLabel.text = content.content
        recommendedSongLabel.text = content.music
    }
}
