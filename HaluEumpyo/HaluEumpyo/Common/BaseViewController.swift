//
//  BaseViewController.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/10.
//

import Foundation

import UIKit
import RxSwift

class BaseViewController: UIViewController {
        // MARK: - Properties
    var disposeBag = DisposeBag()
    
    deinit {
        print("deinit : \(self)")
    }
    
    func setupNavigationBarTitle(title: String) {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.haluEmpyo_black()]
        self.navigationItem.title = title
    }
    
    func setupBaseNavigationBar(backgroundColor: UIColor = .white,
                                titleColor: UIColor = .black,
                                isTranslucent: Bool = false,
                                tintColor: UIColor = .black) {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let appearance = UINavigationBarAppearance()
        let font = UIFont.pretendard(.medium, size: 17)
        
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: titleColor, .font: font]
        appearance.shadowColor = .clear
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.isTranslucent = isTranslucent
        navigationBar.tintColor = tintColor
    }
    
    // MARK: - Vew Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setUpLayoutConstraint()
    }
    
    func configUI() {
        // View Configuration
    }
    
    func setUpLayoutConstraint() {
    }
}
