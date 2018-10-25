//
//  UNavigationController.swift
//  U17
//
//  Created by charles on 2017/9/29.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit

class UNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        // 自定义导航栏背景颜色
        let navView = self.navigationBar.subviews.first
        guard navView != nil else {return}
        // 导航栏背景渐变
        zj_setUpGradientLayer(view: navView!, frame: CGRect(x: 0, y: 0, width: screenWidth, height: kStatuHeight+kNavigationBarHeight), color: kGradientColors)
    }
    func zj_setUpGradientLayer(view : UIView , frame : CGRect , color : [CGColor], corneradiu : CGFloat? = 0){
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = color
        //(这里的起始和终止位置就是按照坐标系,四个角分别是左上(0,0),左下(0,1),右上(1,0),右下(1,1))
        //渲染的起始位置
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        //渲染的终止位置
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
        //设置frame和插入view的layer
        gradientLayer.frame = frame
        gradientLayer.cornerRadius = corneradiu!
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //MARK: 重写跳转
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count>0 {
            viewController.hidesBottomBarWhenPushed = true //跳转之后隐藏
        }
        super.pushViewController(viewController, animated: true)
    }
    // 修改状态栏背景色为渐变色
    func setStatusBarBackgroundColor() {
        let statusBarWindow : UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
        let statusBar : UIView = statusBarWindow.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
