//
//  HomeViewController.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/11.
//

import Foundation
import UIKit

import FSCalendar

import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController {
    // MARK: - property

    private let topView = HomeTopView()
    
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
       return calendar
    }()
    
    private let writeButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 64, height: 64)))
        button.setImage(UIImage(named: "ic_plus"), for: .normal)
        button.layer.cornerRadius = 32
        button.backgroundColor = .white
        return button
    }()
    
    private let buttonView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 32
        view.applyZeplinShadow(alpha: 0.25, x: 2, y: 2, blur: 20, spread: 0)
        return view
    }()
    
    let gregorian = Calendar(identifier: .gregorian)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setDelegation()
        setCalendarStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupBarHidden()
    }
    
    private func setupBarHidden() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func configUI() {
        view.backgroundColor = .white
    }
    
    private func bind() {
        topView.leftButton.rx.tap
            .bind(onNext: { [weak self] in
                let diaryListViewController = DiaryListViewController()
                self?.navigationController?.pushViewController(diaryListViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        writeButton.rx.tap
            .bind(onNext: { [weak self] in
            let writeDiaryViewController = WriteDiaryViewController()
            self?.navigationController?.pushViewController(writeDiaryViewController, animated: true)
        })
        .disposed(by: disposeBag)
    }
    
    override func setUpLayoutConstraint() {
        view.addSubview(topView)
        view.addSubview(buttonView)
        view.addSubview(calendar)
        
        buttonView.addSubview(writeButton)
        
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        buttonView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(45)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(64)
            $0.width.equalTo(64)
        }
        
        writeButton.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(5)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(buttonView.snp.top).offset(-10)
        }
    }
}

extension HomeViewController {
    private func setCalendar() {
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.headerHeight = 0
        calendar.firstWeekday = 2
        calendar.setScope(.month, animated: false)
    }
    
    private func setCalendarStyle() {
        calendar.appearance.weekdayFont = UIFont.pretendard(size: 14)
        calendar.appearance.weekdayTextColor = UIColor.calenderGray()
        calendar.appearance.titleFont = UIFont.pretendard(size: 16)
        calendar.appearance.titleDefaultColor = UIColor.haluEmpyo_black()
        calendar.appearance.titleWeekendColor = UIColor.calenderBlue()
        calendar.appearance.titleTodayColor = UIColor.haluEumpyo_purple()
        calendar.appearance.todayColor = .clear
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.placeholderType = .none
    }
    
    private func setDelegation() {
        calendar.delegate = self
        calendar.dataSource = self
    }
}

extension HomeViewController: FSCalendarDelegate {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        calendar.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let writeDiaryViewController = WriteDiaryViewController()
        self.navigationController?.pushViewController(writeDiaryViewController, animated: true)
    }
}

// MARK: - FSCalendar DataSource

extension HomeViewController: FSCalendarDataSource {
}

// MARK: - FSCalendar Delegate Appearance

extension HomeViewController: FSCalendarDelegateAppearance {
}
