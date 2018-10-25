//
//  VCreateM.swift
//  UTOO
//
//  Created by Lenny on 16/9/22.
//  Copyright © 2016年 Lenny. All rights reserved.
//

import UIKit

var textVPlaceLName = "palceL"

class VCreateM: NSObject {
    
    class func createAlertVC(title:String?,message:String?,style:UIAlertControllerStyle,cancels:String?,btnTs:[String],callBack:((_ index:Int)->())?) -> UIAlertController {
        
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: style)
        for btns in btnTs {
            
            let index = btnTs.index(of: btns)
            let alertAction = UIAlertAction.init(title: btns, style: UIAlertActionStyle.default, handler: { (alertBtn) in
                if callBack != nil {
                    callBack!(index!)
                }
            })
            alertVC.addAction(alertAction)
        }
        if cancels != nil {
            let alertAction = UIAlertAction.init(title: cancels, style: UIAlertActionStyle.cancel, handler: { (alertBtn) in
                if callBack != nil {
                    callBack!(-1)
                }
            })
            alertVC.addAction(alertAction)
        }
        return alertVC
    }
}
