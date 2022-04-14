//
//  DatePickerViewController.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/14.
//

import Foundation

import RxSwift
import UIKit

protocol DatePickerViewDelegate: AnyObject {
    func passData(_ year: String, _ month: String)
}

final class DatePickerViewController: BaseViewController {
    // MARK: - Properties
    
    var year: Int? = 0
    var month: Int? = 0
    
    var yearList: [String] = []
    var monthList: [String] = []
    
    var currentMonthList: [String] = []
    var currentDayList: [String] = []
    let currentDate = AppDate()
    weak var datePickerDataDelegate: DatePickerViewDelegate?
    
    private let pickerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let cancelContainerView: UIView = {
        let view = UIView()
        view.backgroundColor =  .white
        return view
    }()
    
    private lazy var yearPickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private lazy var monthPickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        label.font = UIFont.pretendard(.medium, size: 17)
        label.textColor = UIColor.haluEmpyo_black()
        return label
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        label.font = UIFont.pretendard(.medium, size: 17)
        label.textColor = UIColor.haluEmpyo_black()
        return label
    }()
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray001()
        return view
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("선택", for: .normal)
        button.titleLabel?.font = UIFont.pretendard(.medium, size: 16)
        button.setTitleColor(UIColor.haluEumpyo_purple(), for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private let cancelButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = UIFont.pretendard(.medium, size: 15)
        button.setTitleColor(UIColor.gray003(), for: .normal)
        return button
    }()
    
    private let hStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.backgroundColor = .white

        return stack
    }()
    
    private let yearStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .fillProportionally

        return stack
    }()
    
    private let monthStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .fillProportionally

        return stack
    }()
    
    // MARK: - Life Cycle View
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setDelegation()
        initDateData()
        setPickerViewInitialDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.yearPickerView.subviews[1].backgroundColor = UIColor.clear
            self.monthPickerView.subviews[1].backgroundColor = UIColor.clear
        }
    }
    
    private func setPickerViewInitialDate() {
        guard let unwrappedYear = self.year,
              let unwrappedMonth = self.month else {
            return
        }
        self.yearPickerView.selectRow(unwrappedYear - 2000, inComponent: 0, animated: true)
        self.monthPickerView.selectRow(unwrappedMonth - 1, inComponent: 0, animated: true)
    }
    
    private func setDelegation() {
        monthPickerView.delegate = self
        yearPickerView.delegate = self

        monthPickerView.dataSource = self
        yearPickerView.dataSource = self
    }
    
    private func initDateData() {
        yearList = (2000...currentDate.getYear()).map({String($0)})
        monthList = (1...12).map({String($0)})
        currentMonthList = (1...currentDate.getMonth()).map({String($0)})
    }
    
    private func updateMonthData(_ selectedYear: Int) {
        if self.year != currentDate.getYear() && selectedYear == currentDate.getYear() {
            self.year = selectedYear
            guard let unwrappedMonth = self.month else { return }
            if unwrappedMonth > self.currentDate.getMonth() {
                self.month = self.currentDate.getMonth()
            }
            self.monthPickerView.reloadComponent(0)
        } else if self.year == currentDate.getYear() && selectedYear != currentDate.getYear() {
            self.year = selectedYear
            self.monthPickerView.reloadComponent(0)
        } else {
            self.year = selectedYear
        }
    }
    
    private func dismissDatePicker() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func bind() {
        applyButton.rx.tap.bind(onNext: {
            guard let unwrappedYear = self.year,
                  let unwrappedMonth = self.month else {
                      return
                  }
            self.datePickerDataDelegate?.passData("\(unwrappedYear)", "\(unwrappedMonth)")
            self.dismissDatePicker()
        }).disposed(by: disposeBag)
        
        cancelButton.rx.tap.bind(onNext: {
            self.dismissDatePicker()
        }).disposed(by: disposeBag)
    }
    
    override func setUpLayoutConstraint() {
        view.addSubviews([pickerContainerView, hStackView, seperatorView, applyButton, cancelButtonView, cancelButton])
        
        yearStackView.addArrangedSubview(yearPickerView)
        yearStackView.addArrangedSubview(yearLabel)
        monthStackView.addArrangedSubview(monthPickerView)
        monthStackView.addArrangedSubview(monthLabel)
        
        hStackView.addArrangedSubview(yearStackView)
        hStackView.addArrangedSubview(monthStackView)
        
        pickerContainerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(253)
        }
        
        hStackView.snp.makeConstraints {
            $0.height.equalTo(142)
            $0.width.equalTo(260)
            $0.top.equalToSuperview().offset(28)
//            $0.trailing.equalToSuperview()
//            $0.leading.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        yearLabel.snp.makeConstraints {
            $0.width.equalTo(20)
        }
        
        monthLabel.snp.makeConstraints {
            $0.width.equalTo(20)
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(hStackView.snp.bottom).offset(23)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(1)
        }
        
        applyButton.snp.makeConstraints {
            $0.top.equalTo(seperatorView.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }
        
        cancelButtonView.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(cancelButtonView.snp.top)
            $0.leading.equalTo(cancelButtonView.snp.leading).offset(10)
            $0.trailing.equalTo(cancelButtonView.snp.trailing).inset(10)
            $0.bottom.equalTo(cancelButtonView.snp.bottom)
        }
    }
}

extension DatePickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if pickerView == self.yearPickerView {
            return NSAttributedString(string: yearList[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        } else {
            return NSAttributedString(string: monthList[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case self.yearPickerView:
            guard let unwrappedYear = Int(yearList[row]) else {
                return
            }
            updateMonthData(unwrappedYear)
        case self.monthPickerView:
            guard let unwrappedMonth = Int(monthList[row]) else {
                return
            }
            month = unwrappedMonth
        default:
            break
        }
    }
}

extension DatePickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.yearPickerView {
            return yearList.count
        } else {
            if year == currentDate.getYear() {
                return currentMonthList.count
            }
            return monthList.count
        }
    }
}
