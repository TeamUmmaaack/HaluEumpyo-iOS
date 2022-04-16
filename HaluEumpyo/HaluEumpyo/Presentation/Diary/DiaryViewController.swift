//
//  DiaryViewController.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/16.
//

import Foundation
import UIKit

class DiaryViewController: BaseViewController {
    // MARK: - Property
    private let backButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        $0.setImage(ImageLiteral.btnBack, for: .normal)
    }
    
    private let dateLabel = UILabel().then {
        $0.font = .pretendard(.medium, size: 14)
        $0.textColor = UIColor.gray002()
        $0.textAlignment = .center
    }
    
    private let contentTextView = UITextView().then {
        $0.font = .pretendard(size: 15)
        $0.textColor = UIColor.haluEmpyo_black()
    }
    
    private let dayLabel = UILabel().then {
        $0.font = .pretendard(.medium, size: 14)
        $0.textColor = UIColor.gray002()
        $0.textAlignment = .center
    }
    
    private let recommendMusicContainerView = UIView().then {
        $0.backgroundColor = UIColor.haluEumpyo_background()
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.applyZeplinShadow(alpha: 0.06, x: 0, y: 4, blur: 10, spread: 0)
    }
    
    private let albumCoverView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.image = UIImage(named: "img_album_cover_sample")
    }
    
    private let songTitleLabel = UILabel().then {
        $0.font = UIFont.pretendard(.bold, size: 17)
        $0.textAlignment = .center
        $0.textColor = UIColor.haluEmpyo_black()
    }
    
    private let artistLabel = UILabel().then {
        $0.font = UIFont.pretendard(.regular, size: 14)
        $0.textAlignment = .center
        $0.textColor = UIColor.haluEmpyo_black()
    }
    
    private let noteImageView = UIImageView().then {
        $0.image = ImageLiteral.imgEmotionJoy
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configUI() {
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    // MARK: - inti
    init(contentId: Int?, emotion: Int, content: String, music: String, day: String, date: Int) {
        super.init(nibName: nil, bundle: nil)
        switch emotion {
        case 0:
            noteImageView.image = ImageLiteral.imgEmotionJoy
        case 1:
            noteImageView.image = ImageLiteral.imgEmotionSadness
        case 2:
            noteImageView.image = ImageLiteral.imgEmotionSurprise
        case 3:
            noteImageView.image = ImageLiteral.imgEmotionAngry
        case 4:
            noteImageView.image = ImageLiteral.imgEmotionHate
        case 5:
            noteImageView.image = ImageLiteral.imgEmotionFear
        case 6:
            noteImageView.image = ImageLiteral.imgEmotionSoso
        default:
            noteImageView.image = ImageLiteral.imgEmotionJoy
        }
        dateLabel.text = "\(date)"
        dayLabel.text = "\(day)"
        contentTextView.text = content
        songTitleLabel.text = music.components(separatedBy: "-")[0]
        artistLabel.text = music.components(separatedBy: "-")[1]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUpLayoutConstraint() {
        let containeriewSideMargin: CGFloat = 16
        super.setUpLayoutConstraint()
        
        view.addSubviews([dateLabel, dayLabel, contentTextView, recommendMusicContainerView])
        recommendMusicContainerView.addSubviews([albumCoverView, songTitleLabel, artistLabel, noteImageView])
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }
        
        dayLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom).offset(36)
            $0.leading.equalToSuperview().offset(containeriewSideMargin)
            $0.trailing.equalToSuperview().offset(-containeriewSideMargin)
            $0.bottom.equalTo(recommendMusicContainerView.snp.top).offset(-10)
        }
        
        recommendMusicContainerView.snp.makeConstraints {
            $0.width.equalTo(336)
            $0.height.equalTo(90)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        albumCoverView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17)
            $0.leading.equalToSuperview().offset(12)
            $0.height.equalTo(60)
            $0.width.equalTo(60)
        }
        
        songTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17)
            $0.leading.equalTo(albumCoverView.snp.trailing).offset(15)
            $0.trailing.lessThanOrEqualToSuperview().offset(30)
        }
        
        artistLabel.snp.makeConstraints {
            $0.leading.equalTo(albumCoverView.snp.trailing).offset(15)
            $0.trailing.lessThanOrEqualToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-17)
        }
        
        noteImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-12)
            $0.bottom.equalToSuperview().offset(-17)
            $0.width.equalTo(10)
            $0.height.equalTo(17)
        }
    }
    
    // MARK: - func
    private func bind() {
        backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        setupBaseNavigationBar(backgroundColor: .white, titleColor: .haluEmpyo_black(), isTranslucent: false, tintColor: .haluEmpyo_black())
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
}
