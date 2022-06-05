//
//  DrawerCollectionReusableView.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/12.
//

import Foundation
import UIKit
import RxSwift

final class DrawerCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properties
    
    var currentDate: AppDate?
    let disposeBag = DisposeBag()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(.medium, size: 18)
        label.textColor = UIColor.gray002()
        return label
    }()
    
    private lazy var calenderButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_down"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        addObserver()
        setupLayoutConstraint()
        setInitialDate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - function
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(setData), name: NSNotification.Name("datePickerSelected"), object: nil)
    }
    
    private func setInitialDate() {
        currentDate = AppDate()
        
        guard let year = currentDate?.getYearToString() else { return }
        guard let currentMonth = currentDate?.getMonthToString() else { return }
        
        dateLabel.text = "\(year)년 \(currentMonth)월 일기"
    }
    
    @objc private func setData(notification: NSNotification) {
        if let date = notification.object as? [String] {
            let year = date[0]
            let month = date[1]
            
            dateLabel.text = "\(year)년 \(month)월 일기"
        }
    }
    
    private func make2DigitYear(year: String) -> Substring {
        let startIndex: String.Index = year.index(year.startIndex, offsetBy: 2)
        let doubleDigitYear = year[startIndex...]
        
        return doubleDigitYear
    }
    
    private func configUI() {
        backgroundColor = UIColor.haluEumpyo_background()
    }
    
    private func setupLayoutConstraint() {
        addSubview(dateLabel)
        addSubview(calenderButton)
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
        }
        
        calenderButton.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(dateLabel)
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
         print("Button Clicked")
        NotificationCenter.default.post(name: NSNotification.Name("calendarButtonClicked"), object: nil)
    }
}
