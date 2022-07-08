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
    private var writeDiaryRequest = WriteDiaryRequestModel(content: "")
    
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
        setup()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func configUI() {
        super.configUI()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {       self.view.endEditing(true)
    }
    
    // MARK: - Functions
    
    private func setup() {
        setInitialDate()
        setupKeyboardHiding()
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        let textViewOffset = -(keyboardHeight + 20)
        contentTextView.snp.updateConstraints {
            $0.bottom.equalToSuperview().offset(textViewOffset)
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        contentTextView.snp.updateConstraints {
            $0.bottom.equalToSuperview()
        }
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
        topView.rightButton.rx.tap
            .bind(onNext: { [weak self] in
                CustomActivityIndicator.shared.show()
                DispatchQueue.main.asyncAfter(deadline: .now()+3.0 ) {
                    CustomActivityIndicator.shared.hide()
                    self?.postDiary()
                }
            })
            .disposed(by: disposeBag)
        
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
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        contentTextView.rx.text
            .asDriver()
            .map { [weak self] content -> Bool in
            guard let self = self else { return false }
            if content?.isEmpty ?? true || self.isPlaceHolderString(content ?? "") {
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

extension WriteDiaryViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension WriteDiaryViewController {
    func postDiary() {
        writeDiaryRequest.content = contentTextView.text
        DiaryService.shared.postDiary(parameter: writeDiaryRequest) { (response) in
            switch response {
            case .success(let data):
                if let data = data as? [Recommendation] {
                    let recommendMusicViewController = RecommendMusicViewController(recommendModel: data[0])
                        self.navigationController?.pushViewController(recommendMusicViewController, animated: true)
                }
            case .requestErr(let message):
                print(message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .none:
                print("none")
            }
        }
    }
}
