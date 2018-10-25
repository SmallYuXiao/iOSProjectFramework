//
//  ExceptionView.swift
//  UTOOS
//
//  Created by Frekle on 2017/7/29.
//  Copyright © 2017年 Wang. All rights reserved.
//

import UIKit

protocol ExceptionViewButtonClickDeleagete {
    func reloadButtonClick()
}

class ExceptionView: UIView {
    
    var delegate: ExceptionViewButtonClickDeleagete?

    //头像
    public lazy var errorImageView: UIImageView = {
        let cw = UIImageView()
        cw.image = UIImage(named: "network_loadFail")
        return cw
    }()
    public lazy var errorLabel: UILabel = {
        let cw = UILabel()
        cw.text = "您的网络好像出现了问题"
        cw.textColor = UIColor.green
        cw.font = UIFont.size12
        return cw
    }()
    public lazy var reloadButton: UIButton = {
        let cw = UIButton()
       cw.setTitle("重新加载", for: .normal)
        return cw
    }()
//    convenience init(imageName: String, error: String, reloadString: String) {
//        self.init(frame: CGRect.zero)
//        initUserInterface(imageName: imageName, error: error, reloadString: reloadString)
//    }
    
//    ExceptionView.show(view: view, imageName: "network_loadFail", error: "您的网络好像出现了问题", reloadString: "重新加载", delegate: self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUserInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUserInterface() {
        self.backgroundColor = UIColor.white
        
        self.addSubview(errorImageView)
        errorImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).multipliedBy(0.7)
        }
        
        self.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        reloadButton.layer.cornerRadius = 5
        reloadButton.backgroundColor = UIColor.wlYellow
        reloadButton.addTarget(self, action: #selector(reloadButtonClicked), for: .touchUpInside)
        self.addSubview(reloadButton)
        reloadButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(errorLabel.snp.bottom).offset(30)
            make.width.equalTo(100)
            make.height.equalTo(27)
        }
    }
    
    @objc func reloadButtonClicked() {
//        self.isHidden = true
        self.delegate?.reloadButtonClick()
    }
    
//    static func show(view: UIView, imageName: String, error: String, reloadString: String, delegate: ExceptionViewButtonClickDeleagete) {
//        let errorContentView = ExceptionView(imageName: imageName, error: error, reloadString: reloadString)
//        errorContentView.delegate = delegate
//        errorContentView.backgroundColor = UIColor.white
//        view.addSubview(errorContentView)
//        errorContentView.snp.makeConstraints { (make) in
//            make.edges.equalTo(view)
//        }
//    }

}
