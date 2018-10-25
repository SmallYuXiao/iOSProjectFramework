//
//  LoginViewController.swift
//  XinYiFu
//
//  Created by 余潇逸 on 2018/10/23.
//  Copyright © 2018年 xiaoyu. All rights reserved.
//

import UIKit

class LoginViewController: UBaseViewController {
    //新用户button
    let newUser:UIButton = {
        let newUser = UIButton()
        newUser.setTitleColor(UIColor.rgb(73, 130, 228), for: .normal)
        newUser.titleLabel?.font = UIFont.size15
        newUser.setTitle("新用户", for: .normal)
        newUser.addTarget(self, action: #selector(responseToNewUserButton), for: .touchUpInside)
        newUser.layer.cornerRadius = 3
        newUser.layer.borderWidth = 1
        newUser.layer.borderColor = UIColor.rgb(73, 130, 228).cgColor
        newUser.layer.masksToBounds = true
        return newUser
    }()
    /***👋 新用户的点击事件 👋**/
    @objc func responseToNewUserButton(){
        /***👋 点击事件 👋**/
        navigationController?.pushViewController(NewBaseViewController(), animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(newUser)
        newUser.snp.makeConstraints { (make) in
            make.width.height.equalTo(Scale.height(100))
            make.center.equalToSuperview()
        }
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
