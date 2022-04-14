//
//  HomeViewController.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/11.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController {
    // MARK: - property

    private let topView = HomeTopView()
    
    private lazy var writeButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 64, height: 64)))
        button.backgroundColor = .red
        button.setImage(UIImage(named: "ic_plus"), for: .normal)
        // 둥근 모서리 및 그림자 생성 코드
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 6
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
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
            .asDriver()
            .drive(onNext: { [weak self] in
                let diaryListViewController = DiaryListViewController()
                self?.navigationController?.pushViewController(diaryListViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    override func setUpLayoutConstraint() {
        view.addSubview(topView)
        view.addSubview(writeButton)
        
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        writeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(45)
            $0.centerX.equalToSuperview()
        }
    }
}
