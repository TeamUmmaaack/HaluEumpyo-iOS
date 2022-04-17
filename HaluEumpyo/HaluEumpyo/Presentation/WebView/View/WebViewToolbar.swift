//
//  WebViewToolbar.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/04/17.
//

import UIKit

final class WebViewToolbar: UIToolbar {
    
    enum Size {
        static let toolbarHeight: CGFloat = 44
    }
    
    // MARK: - property
    
    let backBarButton = UIBarButtonItem(image: UIImage(named: "chevron.left")?.withRenderingMode(.alwaysOriginal),
                                        style: .plain,
                                        target: nil,
                                        action: nil)
    let forwardBarButton = UIBarButtonItem(image: UIImage(named: "chevron.right")?.withRenderingMode(.alwaysOriginal),
                                           style: .plain,
                                           target: nil,
                                           action: nil)
    let shareBarButton = UIBarButtonItem(image: UIImage(named: "square.and.arrow.up")?.withRenderingMode(.alwaysOriginal),
                                         style: .plain,
                                         target: nil,
                                         action: nil)
    let safariBarButton = UIBarButtonItem(image: UIImage(named: "safari")?.withRenderingMode(.alwaysOriginal),
                                          style: .plain,
                                          target: nil,
                                          action: nil)
    let checkReadBarButton = UIBarButtonItem(image: UIImage(named: "book")?.withRenderingMode(.alwaysOriginal),
                                             style: .plain,
                                             target: nil,
                                             action: nil)
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
