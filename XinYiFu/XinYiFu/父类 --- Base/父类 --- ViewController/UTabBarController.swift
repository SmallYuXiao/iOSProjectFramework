//
//  UTabBarController.swift
//  U17
//
//  Created by charles on 2017/9/29.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit

class UTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAllViewController()
        
        //tabBar 底部工具栏背景颜色 (以下两个都行)
//        self.tabBar.barTintColor = UIColor.clear
        //        self.tabBar.backgroundColor = UIColor.white
        
        //设置 tabBar 工具栏字体颜色 (未选中  和  选中)
        // 设置图片和文字选中时的颜色   必须设置（系统默认选中蓝色）
        self.tabBar.tintColor = UIColor.red
        //        self.tabBar.isTranslucent = false
    }
    // 添加所有控件
    func setUpAllViewController() -> Void {
         //设置 tabBar 工具栏字体颜色 (未选中  和  选中)
        setUpChildController(LoginViewController(), "商城","商城未选中","商城选中")
        setUpChildController(LoginViewController(), "贷款",  "贷款未选中",  "贷款选中")
        setUpChildController(LoginViewController(), "分享",  "分享未选中",  "分享选中")
        setUpChildController(LoginViewController(), "我的",  "我的未选中",  "我的选中")
    }
    
    // 设置子控件属性
    private func setUpChildController(_ controller : UIViewController,_ title : String,_ norImage : String,_ selectedImage : String){
        controller.tabBarItem.title = title
        // 修改TabBar标题位置
        controller.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3)
        controller.tabBarItem.image = UIImage(named: norImage)
        controller.tabBarItem.selectedImage = UIImage(named: selectedImage)
        // 设置 NavigationController
        let nav = UNavigationController(rootViewController: controller)
        controller.title = title
        self.addChildViewController(nav)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
