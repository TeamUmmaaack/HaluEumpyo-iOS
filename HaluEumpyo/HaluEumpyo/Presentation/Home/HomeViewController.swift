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
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.haluEmpyo_black()
        label.font = UIFont.pretendard(.regular, size: 20)
        return label
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
    
    private var joyList: [String] = []
    private var sadList: [String] = []
    private var angryList: [String] = []
    private var scaredList: [String] = []
    private var sosoList: [String] = []
    
    //Used by one of the example methods
    var datesWithEvent = ["2022-04-01", "2022-04-06", "2022-04-12", "2022-04-23"]

    var selectedDate: String = Date().toStringTypeOne
    
    private let feedbackPopUp = FeedBackPopUpViewController()
    
    let gregorian = Calendar(identifier: .gregorian)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setDelegation()
        setDiaryContents()
        setCalendar()
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
        
        topView.rightButton.rx.tap
            .bind(onNext: { [weak self] in
                let settingViewController = SettingViewController()
                self?.navigationController?.pushViewController(settingViewController, animated: true)
            }).disposed(by: disposeBag)
        
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
            $0.top.equalTo(topView.snp.bottom).offset(15)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(buttonView.snp.top).offset(-60)
        }
    }
    
    func setDiaryContents() {
        joyList.append(contentsOf: ["2022-04-06", "2022-04-11", "2022-04-12"])
        sadList.append(contentsOf: ["2022-04-08"])
        angryList.append(contentsOf: ["2022-04-15", "2022-4-20"])
        scaredList.append(contentsOf: ["2022-04-19"])
        sosoList.append(contentsOf: ["2022-04-23"])
    }
}

extension HomeViewController {
    private func setCalendar() {
        calendar.locale = Locale(identifier: "en_USA")
        calendar.headerHeight = 80
        calendar.firstWeekday = 2
        calendar.setScope(.month, animated: false)
    }
    
    private func setCalendarStyle() {
        calendar.appearance.weekdayFont = UIFont.pretendard(size: 14)
        calendar.appearance.weekdayTextColor = UIColor.calenderGray()
        calendar.appearance.titleFont = UIFont.pretendard(size: 16)
        calendar.appearance.titleDefaultColor = UIColor.haluEmpyo_black()
        calendar.appearance.titleTodayColor = UIColor.haluEumpyo_purple()
        calendar.appearance.titleWeekendColor = UIColor.calenderBlue()
        calendar.appearance.todayColor = .clear
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.placeholderType = .none
        calendar.appearance.headerTitleColor = .haluEmpyo_black()
        calendar.appearance.headerDateFormat = "YYYY\n MMMM"
        calendar.appearance.headerTitleFont = UIFont.pretendard(size: 20)
        calendar.appearance.caseOptions = FSCalendarCaseOptions.headerUsesUpperCase
        calendar.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesUpperCase
    }
    
    private func setDelegation() {
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.register(CalendarCell.self, forCellReuseIdentifier: String(describing: CalendarCell.self))
    }
}

extension HomeViewController: FSCalendarDelegate {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        calendar.headerHeight = 80
        calendar.reloadData()
    }
}

// MARK: - FSCalendar DataSource

extension HomeViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        guard let cell = calendar.dequeueReusableCell(
            withIdentifier: String(describing: CalendarCell.self),
            for: date,
            at: position
        ) as? CalendarCell else { return FSCalendarCell() }
        configure(cell: cell, for: date, at: position)
        return cell
    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        guard let cell = cell as? CalendarCell else { return }
        
        var filledType = FilledType.none
        var selectedType = SelectedType.not
        var width: CGFloat = 32
        var yPosition: CGFloat = 2
        let formattedDate = date.toString(of: .year)
        
        if self.gregorian.isDateInToday(date) {
            filledType = .today
        } else if joyList.contains(formattedDate) {
            filledType = .joy
        } else if sadList.contains(formattedDate) {
            filledType = .sad
        } else if angryList.contains(formattedDate) {
            filledType = .angry
        } else if scaredList.contains(formattedDate) {
            filledType = .surprise
        } else {
            filledType = .none
        }
        
        if calendar.selectedDates.contains(date) && !gregorian.isDateInToday(date) {
            width = 44
            yPosition = -4
            selectedType = .single
        }
        
        cell.width = width
        cell.yPosition = yPosition
        cell.selectedType = selectedType
        cell.filledType = filledType
    }
}

// MARK: - FSCalendar Delegate Appearance

extension HomeViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date.toStringTypeOne
        calendar.select(date)
        
        self.configureVisibleCells()
        
        let writeDiaryViewController = WriteDiaryViewController()
        self.navigationController?.pushViewController(writeDiaryViewController, animated: true)
    }
    
    private func configureVisibleCells() {
        calendar.visibleCells().forEach { (cell) in
            let date = calendar.date(for: cell)
            let position = calendar.monthPosition(for: cell)
            self.configure(cell: cell, for: date!, at: position)
        }
    }
}

extension HomeViewController: PopUpActionProtocol {
    func cancelButtonDidTap(_ button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func confirmButtonDidTap(_ button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
