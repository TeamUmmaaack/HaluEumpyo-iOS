//
//  WriteDiaryViewController.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/15.
//

import Foundation

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class WriteDiaryViewController: BaseViewController {    
    // MARK: - Property
    private let topView = WriteDiaryTopView()
    var currentDate: AppDate?
    
    private let contextView = UIView().then {
        $0.backgroundColor = UIColor.white
    }
    
    private let dateLabel = UILabel().then {
        $0.font = .pretendard(.medium, size: 14)
        $0.textColor = UIColor.gray002()
        $0.textAlignment = .center
    }
    
    private let dayLabel = UILabel().then {
        $0.font = .pretendard(.medium, size: 14)
        $0.textColor = UIColor.gray002()
        $0.textAlignment = .center
    }
    
    private let contentTextView = UITextView().then {
        $0.text = "오늘의 일기를 작성해보세요!"
        $0.font = .pretendard(size: 15)
        $0.textColor = UIColor.lightGray
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialDate()
        bind()
    }
    
    override func configUI() {
        super.configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setInitialDate() {
        currentDate = AppDate()
        
        guard let year = currentDate?.getYearToString() else { return }
        guard let currentMonth = currentDate?.getMonthToString() else { return }
        guard let day = currentDate?.getDayToString() else { return }
        guard let dayOfWeek = currentDate?.getWeekday() else { return }
        print(dayOfWeek)
        
        dateLabel.text = "\(year)년 \(currentMonth)월 \(day)일"
        dayLabel.text = "\(dayOfWeek)요일"
    }
    
    func isPlaceHolderString(_ string: String) -> Bool {
        return string == "오늘의 일기를 작성해보세요!"
    }
    
    private func bind() {
        contentTextView.rx.didBeginEditing
            .asDriver()
            .compactMap { [weak self] _ in self?.contentTextView.text }
        .filter { [weak self] text in
            self?.isPlaceHolderString(text) == true
        }
        .drive(onNext: { [weak self] _ in
            self?.contentTextView.text = nil
            self?.contentTextView.textColor = UIColor.haluEmpyo_black()
        })
        .disposed(by: disposeBag)
        
        contentTextView.rx.didEndEditing
            .asDriver()
            .compactMap { [weak self] _ in self?.contentTextView.text }
            .filter { [weak self] text in
                self?.contentTextView.text == nil
            }
            .drive(onNext: { [weak self] _ in
                self?.contentTextView.text = "오늘의 일기를 작성해보세요!"
                self?.contentTextView.textColor = .lightGray
            })
            .disposed(by: disposeBag)
        
        topView.leftButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        contentTextView.rx.text
            .asDriver()
            .map { [weak self] content -> Bool in
            guard let self = self else { return false }
            if (content?.isEmpty ?? true || self.isPlaceHolderString(content ?? ""))  {
                return false
            } else {
                return true
            }
        }
            .drive(onNext: { [weak self] writeButtonEnabled in
                guard let self = self else { return }
                self.topView.rightButton.isEnabled = writeButtonEnabled
                self.topView.rightButton.setImage(writeButtonEnabled ? ImageLiteral.btnSendActivated : ImageLiteral.btnSend, for: .normal)
            })
            .disposed(by: disposeBag)
    }
    
    override func setUpLayoutConstraint() {
        view.addSubviews([topView, dateLabel, dayLabel, contentTextView])
        
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        dayLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
    }
}
