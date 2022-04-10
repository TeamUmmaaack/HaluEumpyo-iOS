//
//  BaseViewController.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/10.
//

import Foundation

import UIKit

class BaseViewController: UIViewController {
    
    deinit {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
