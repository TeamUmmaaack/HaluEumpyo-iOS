//
//  SettingViewController.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/24.
//

import UIKit

final class SettingViewController: BaseViewController {
    
    private let backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        button.setImage(UIImage(named: "btn_back"), for: .normal)
        return button
    }()
    
    var settingTitles = ["문의하기", "개발자 정보", "서비스 운영정책", "개인정보 이용약관", "로그아웃"]
    
    lazy var settingTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        tableView.estimatedRowHeight = 60
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func configUI() {
        view.backgroundColor = .white
    }
    
    override func setUpLayoutConstraint() {
        view.addSubview(settingTableView)
        
        settingTableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
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
        title = "환경"
        setupBaseNavigationBar(backgroundColor: UIColor.white,
                               titleColor: UIColor.haluEmpyo_black(),
                               isTranslucent: false,
                               tintColor: UIColor.haluEmpyo_black())
        navigationItem.leftBarButtonItem = makeBarButtonItem(with: backButton)
    }
    
    private func makeBarButtonItem(with button: UIButton) -> UIBarButtonItem {
        return UIBarButtonItem(customView: button)
    }
}

// MARK: - UITableViewDelegate

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - UITableViewDataSource

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = settingTableView.dequeueReusableCell(withIdentifier: "cell") as? UITableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.textLabel?.text = settingTitles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
