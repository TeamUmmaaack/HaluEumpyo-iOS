//
//  DiaryViewController.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/16.
//

import Foundation
import UIKit

import Kingfisher

class DiaryViewController: BaseViewController {
    // MARK: - Property
    private var songTitle: String?
    private var artistName: String?
    
    private let diary: Diary
    private let locale: String
    
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
        $0.isEditable = false
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
        $0.applyZeplinShadow(alpha: 0.1, x: 0, y: 4, blur: 10, spread: 0)
    }
    
    private let albumCoverImageView = UIImageView().then {
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        recommendMusicContainerView.addGestureRecognizer(tapGesture)
        let style = NSMutableParagraphStyle()
        let fontSize: CGFloat = 15
        let lineheight = fontSize * 1.6  //font size * multiple
        style.minimumLineHeight = lineheight
        style.maximumLineHeight = lineheight

        contentTextView.attributedText = NSAttributedString(
            string: contentTextView.text,
          attributes: [
            .paragraphStyle: style
          ])
        contentTextView.font = .pretendard(.regular, size: fontSize)
        configure(from: diary)
    }
    
    override func configUI() {
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - init
    init(diary: Diary, locale: String) {
        self.diary = diary
        self.locale = locale
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUpLayoutConstraint() {
        let containeriewSideMargin: CGFloat = 16
        super.setUpLayoutConstraint()
        
        view.addSubviews([dateLabel, dayLabel, contentTextView, recommendMusicContainerView])
        recommendMusicContainerView.addSubviews([albumCoverImageView, songTitleLabel, artistLabel, noteImageView])
        
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
        
        albumCoverImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17)
            $0.leading.equalToSuperview().offset(12)
            $0.height.equalTo(60)
            $0.width.equalTo(60)
        }
        
        songTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17)
            $0.leading.equalTo(albumCoverImageView.snp.trailing).offset(15)
            $0.trailing.lessThanOrEqualToSuperview().offset(30)
        }
        
        artistLabel.snp.makeConstraints {
            $0.leading.equalTo(albumCoverImageView.snp.trailing).offset(15)
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
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        print("클릭됨")
        let urlString = diary.url
        let webViewController = WebViewController(urlString: "\(urlString)")
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
    
    private func makeURL(artistName: String, songtitle: String) -> String {
        let query = "\(artistName)+\(songtitle)"
        let url = query.replacingOccurrences(of: " ", with: "+")
        print("수정된 url: \(url)")
        return url
    }
    
    // MARK: - func
    private func configure(from diary: Diary) {
        contentTextView.text = diary.content
        songTitleLabel.text = diary.title
        artistLabel.text = diary.singer
        let text = setDate(locale: locale, date: diary.createdAt)
        dateLabel.text = text.components(separatedBy: "-")[0]
        dayLabel.text = text.components(separatedBy: "-")[1]
        let url = URL(string: diary.cover)
        albumCoverImageView.kf.setImage(with: url)
    }
    
    private func setDate(locale: String, date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: locale)
        dateFormatter.dateFormat = Date.FormatType.calendar.description
        let convertedDate = dateFormatter.date(from: date)
        guard let string = convertedDate?.toString(of: .day) else { return "" }
        return string
    }
    
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
