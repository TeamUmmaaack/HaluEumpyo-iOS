//
//  ModalPresentationController.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/14.
//

import UIKit

class ModalPresentationController: UIPresentationController {
    let backgroundView: UIView!
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    var check: Bool = false
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        backgroundView = UIView()
        backgroundView.backgroundColor = .darkGray
        super.init(presentedViewController: presentedViewController, presenting: presentedViewController)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.backgroundView.isUserInteractionEnabled = true
        self.backgroundView.addGestureRecognizer(tapGestureRecognizer)
    }
    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(origin: CGPoint(x: 0,
                               y: self.containerView!.frame.height*0.08),
               size: CGSize(width: self.containerView!.frame.width,
                            height: self.containerView!.frame.height * 0.92))
    }
    override func presentationTransitionWillBegin() {
        self.backgroundView.alpha = 0
        self.containerView!.addSubview(backgroundView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in self.backgroundView.alpha = 0.7},
                                                                    completion: nil)
    }
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in self.backgroundView.alpha = 0},
                                                                    completion: { _ in self.backgroundView.removeFromSuperview()})
    }
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        if check {
            presentedView?.frame = frameOfPresentedViewInContainerView
            check.toggle()
        } else {
            presentedView?.frame = CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * 0.55), size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height * 0.45))
            check.toggle()
        }
        backgroundView.frame = containerView!.bounds
    }

    @objc func dismissController() {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}
