//  RecommendMusicViewContorller.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/18.
//

import Foundation
import UIKit

import RxSwift
import Kingfisher

final class RecommendMusicViewController: BaseViewController {
    // MARK: - Property
    private let backButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        $0.setImage(ImageLiteral.btnBack, for: .normal)
    }
    private let buttonView: UIView = UIView()
    
    private let buttonBackgroundImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = ImageLiteral.btnListen
    }
    
    var recommendation: Recommendation?
    
    let listenButton: UIButton = {
        let button = UIButton()
        if #available(iOS 15.0, *) {
            let container = AttributeContainer([.font: UIFont.pretendard(size: 15), .foregroundColor: UIColor.white])
            var configuration = UIButton.Configuration.plain()
            configuration.attributedTitle = AttributedString("들으러 가기", attributes: container)
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 9, trailing: 0)
            configuration.image = ImageLiteral.icPlay
            configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 10)
            configuration.imagePadding = 4
            button.configuration = configuration
        } else {
            let button = UIButton()
            button.setImage(ImageLiteral.icPlay, for: .normal)
            button.setTitle("들으러 가기", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        }
        return button
    }()
    
    private let backgroundImageView = UIImageView().then {
        $0.image = ImageLiteral.bgEmotionSoso
        $0.contentMode = .scaleAspectFill
    }
    
    private let subtitleLabel = UILabel().then {
        $0.text = "오늘의 감정을 바탕으로 추천했어요"
        $0.textColor = .white
        $0.font = .pretendard(.regular, size: 15)
        $0.textAlignment = .center
    }
    
    private let seperatorLine1 = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let seperatorLine2 = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let albumCoverImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.image = UIImage(named: "img_album_cover_sample")
    }
    
    private let songTitleLabel = UILabel().then {
        $0.text = "See You Again"
        $0.textColor = .white
        $0.font = .pretendard(.semiBold, size: 28)
        $0.textAlignment = .center
    }
    
    private let artistLabel = UILabel().then {
        $0.text = "Charlie Puth"
        $0.textColor = .white
        $0.font = .pretendard(.semiBold, size: 20)
        $0.textAlignment = .center
    }
    
    // MARK: - init
    init(recommendModel: Recommendation) {
        super.init()
        recommendation = recommendModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle View
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupBarHidden()
    }
    
    // MARK: - Config
    override func configUI() {
        view.backgroundColor = .white
        setContent(content: recommendation)
    }
    
    private func setupBarHidden() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func setUpLayoutConstraint() {
        view.addSubview(backgroundImageView)
        view.addSubview(buttonView)
        view.addSubview(buttonBackgroundImageView)
        view.addSubview(listenButton)
        
        backgroundImageView.addSubviews([subtitleLabel, seperatorLine1, albumCoverImageView, songTitleLabel, artistLabel, seperatorLine2])
        
        buttonView.addSubview(backButton)
        
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        buttonView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(17)
            $0.bottom.equalToSuperview().inset(5)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(buttonView.snp.bottom).offset(37)
            $0.leading.trailing.equalToSuperview()
        }
        
        seperatorLine1.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(37)
            $0.leading.equalToSuperview().offset(54)
            $0.trailing.equalToSuperview().offset(-54)
            $0.height.equalTo(1)
        }
        
        albumCoverImageView.snp.makeConstraints {
            $0.top.equalTo(seperatorLine1.snp.bottom).offset(37)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(230)
            $0.height.equalTo(230)
        }
        
        songTitleLabel.snp.makeConstraints {
            $0.top.equalTo(albumCoverImageView.snp.bottom).offset(37)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        artistLabel.snp.makeConstraints {
            $0.top.equalTo(songTitleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        seperatorLine2.snp.makeConstraints {
            $0.top.equalTo(artistLabel.snp.bottom).offset(37)
            $0.leading.equalToSuperview().offset(54)
            $0.trailing.equalToSuperview().offset(-54)
            $0.height.equalTo(1)
        }
        
        buttonBackgroundImageView.snp.makeConstraints {
            $0.top.equalTo(seperatorLine2.snp.bottom).offset(37)
            $0.width.equalTo(145)
            $0.centerX.equalToSuperview()
        }
        
        listenButton.snp.makeConstraints {
            $0.top.equalTo(buttonBackgroundImageView.snp.top)
            $0.width.equalTo(145)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(buttonBackgroundImageView.snp.bottom)
        }
    }
    
    private func setContent(content: Recommendation?) {
        if let imageURL = content?.cover, let url = URL(string: imageURL) {
            albumCoverImageView.kf.setImage(with: url)
        }
        
        if let songTitle = content?.title {
            songTitleLabel.text = songTitle
        }
        
        if let artistTitle = content?.singer {
            artistLabel.text = artistTitle
        }
        
        if let emotionId = content?.emotionID {
            switch emotionId {
            case 1:
                backgroundImageView.image = ImageLiteral.bgEmotionJoy
            case 2:
                backgroundImageView.image = ImageLiteral.bgEmotionSadness
            case 3:
                backgroundImageView.image = ImageLiteral.bgEmotionSurprise
            case 4:
                backgroundImageView.image = ImageLiteral.bgEmotionAngry
            case 5:
                backgroundImageView.image = ImageLiteral.bgEmotionHate
            case 6:
                backgroundImageView.image = ImageLiteral.bgEmotionFear
            case 7:
                backgroundImageView.image = ImageLiteral.bgEmotionSoso
            default:
                backgroundImageView.image = ImageLiteral.bgEmotionJoy
            }
        }
    }

    private func bind() {
        backButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.navigationController?.popToViewController(ofClass: HomeViewController.self)
            })
            .disposed(by: disposeBag)
        
        listenButton.rx.tap
            .bind(onNext: { [weak self] in
                let urlString = self?.recommendation?.url ?? ""
            let webViewController = WebViewController(urlString: urlString)
            self?.navigationController?.pushViewController(webViewController, animated: true)
        })
            .disposed(by: disposeBag)
    }
}
