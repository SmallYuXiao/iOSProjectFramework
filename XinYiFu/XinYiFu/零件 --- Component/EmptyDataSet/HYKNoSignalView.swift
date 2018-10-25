//
//  HYKNoSignalView.swift
//  U17
//
//  Created by 余潇逸 on 2018/8/21.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

class HYKNoSignalView: UIView {
    /***👋 缺省页 👋**/
    
    //待签
    lazy var defaultButton: UIButton = {
        let bn = UIButton(type: .custom)
        bn.setImage(UIImage(named: "暂无数据")?.withRenderingMode(.alwaysOriginal), for: .normal)
        bn.titleLabel?.font = UIFont.size14
        bn.setTitleColor(UIColor.rgb(51, 51, 51), for: .normal)
        //        bn.addTarget(self, action: #selector(jumpWill), for: .touchUpInside)
        bn.verticalImageAndTitle(8.5)
        return bn
    }()
    
    lazy var textLable:UILabel = {
        let tl = UILabel()
        tl.text = "暂无数据,请点击刷新..."
        tl.textColor = UIColor.rgb(153, 153, 153)
        tl.font = UIFont.size12
        return tl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        configUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configUI() {
        addSubview(defaultButton)
        defaultButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(Scale.height(-130))
        }
        addSubview(textLable)
        textLable.snp.makeConstraints {
            $0.centerX.equalTo(defaultButton.snp.centerX)
            $0.top.equalTo(defaultButton.snp.bottom).offset(Scale.height(12))
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
