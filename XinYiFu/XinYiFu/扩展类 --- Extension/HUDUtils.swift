//
//  ToastUtils.swift
//  Homer
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import MBProgressHUD

// MBProgressHUD快捷展示
extension UIView {
    
    fileprivate static let HUBHideDelay = 1.5
    
    func showHUD(_ msg : String?){
        
        let hub = MBProgressHUD.showAdded(to: self, animated: true)
        hub.isUserInteractionEnabled = false
        hub.mode = .text
        hub.detailsLabel.text = msg
        hub.detailsLabel.font = UIFont.systemFont(ofSize: 16)
        hub.hide(animated: true, afterDelay: UIView.HUBHideDelay)
    }
    
    func showLoading() {

        MBProgressHUD.showAdded(to: self, animated: true)
    }
    
    func hidAllHud() {
        MBProgressHUD.hide(for: self, animated: true)
    }
}
