//
//  UBaseViewController.swift
//  U17
//
//  Created by charles on 2017/9/29.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit
import SnapKit
import Then
import Reusable

class UBaseViewController: UIViewController {
   open lazy var exceptionView: ExceptionView = {
        return ExceptionView()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        exceptionView.isHidden = true
        exceptionView.delegate = self
        view.addSubview(exceptionView)
        exceptionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        view.backgroundColor = UIColor.background
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    func configUI() {
    }
    func configNavigationBar() {
        guard let navi = navigationController else { return }
        if navi.visibleViewController == self {
            navi.setNavigationBarHidden(false, animated: true)
            if navi.viewControllers.count > 1 {
                // 返回按钮
                let backButton = UIButton(type: .custom)
                // 设置frame
                backButton.frame = CGRect(x: 200, y: 13, width: 40, height: 40)
                backButton.setImage(UIImage(named:"appBack"), for: .normal)
                backButton.addTarget(self, action: #selector(pressBack), for: .touchUpInside)
                // 自定义导航栏的UIBarButtonItem类型的按钮
                let backView = UIBarButtonItem(customView: backButton)
                // 重要方法，用来调整自定义返回view距离左边的距离
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                barButtonItem.width = 10
                // 返回按钮设置成功
                navigationItem.leftBarButtonItems = [barButtonItem, backView]
            }
        }
    }
    @objc func pressBack() {
        navigationController?.popViewController(animated: true)
    }
}
extension UBaseViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
}
extension UBaseViewController: ExceptionViewButtonClickDeleagete {
    func reloadButtonClick() {
//        if let api = api {
//            shouldIntercept = false
//            webView.loadWebApi(api: api)
//        } else if let urlString = urlString {
//            self.urlString = urlString
//        }
    }
}
