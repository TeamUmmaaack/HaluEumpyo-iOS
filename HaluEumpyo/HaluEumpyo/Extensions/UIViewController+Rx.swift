//
//  UIViewController+Rx.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/11.
//

import UIKit

import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
        let event = self.methodInvoked(#selector(Base.viewDidLoad))
            .map { _ in }

        return ControlEvent(events: event)
    }

    var viewWillAppear: ControlEvent<Void> {
        let event = self.methodInvoked(#selector(Base.viewWillAppear(_:)))
            .map { _ in }

        return ControlEvent(events: event)
    }
}

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
