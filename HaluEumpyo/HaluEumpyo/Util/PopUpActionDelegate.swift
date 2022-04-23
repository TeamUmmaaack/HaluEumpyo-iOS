//
//  PopUpActionDelegate.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/23.
//

import UIKit

protocol PopUpActionProtocol: AnyObject {
    func cancelButtonDidTap(_ button: UIButton)
    func confirmButtonDidTap(_ button: UIButton)
    func confirmButtonDidTap(_ button: UIButton, textInfo: String)
}

extension PopUpActionProtocol {
    func confirmButtonDidTap(_ button: UIButton) { }
    func confirmButtonDidTap(_ button: UIButton, textInfo: String) { }
}
