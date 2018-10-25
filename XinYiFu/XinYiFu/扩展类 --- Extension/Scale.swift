//
//  Scale.swift
//  UTOO
//
//  Created by Frekle on 2017/2/16.
//  Copyright © 2017年 Lenny. All rights reserved.
//

import Foundation
import UIKit

struct Scale {
    
    //iphone5s 以及iPhone X的适配
    static func iphonX() ->Bool {
        if UIScreen.main.bounds.height == 812.0{
            return true
        }else{
            return false
        }
    }
    static func iphon5s() ->Bool {
        if UIScreen.main.bounds.height == 568.0{
            return true
        }else{
            return false
        }
    }
    
    static func width(_ width: CGFloat) -> CGFloat {
        return width * Screen.width / 375.0
    }
    
   
    static func height(_ height: CGFloat) -> CGFloat {
        return height * Screen.height / 667.0
    }
    
    static func selectHeight(_ iPhone4: CGFloat, iPhone5: CGFloat, iPhone6: CGFloat, iPhone6Plus: CGFloat) -> CGFloat {
        switch Screen.height {
        case 480:
            return iPhone4
        case 568:
            return iPhone5
        case 667:
            return iPhone6
        case 736:
            return iPhone6Plus
        default:
            return CGFloat.leastNormalMagnitude
        }
    }
    
}
