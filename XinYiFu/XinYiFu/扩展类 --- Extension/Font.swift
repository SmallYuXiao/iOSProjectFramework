//
//  Font.swift
//  UTOO
//
//  Created by Frekle on 2017/2/16.
//  Copyright © 2017年 Lenny. All rights reserved.
//

import UIKit

extension UIFont {
    
    open class var size15: UIFont {
        get { return UIFont.systemFont(ofSize: Scale.width(15)) }
    }
    
    open class var size14: UIFont {
        get { return UIFont.systemFont(ofSize: Scale.width(14)) }
    }
    
    open class var size13: UIFont {
        get { return UIFont.systemFont(ofSize: Scale.width(13)) }
    }
    open class var size12: UIFont {
        get { return UIFont.systemFont(ofSize: Scale.width(12)) }
    }
    
    open class var size18: UIFont {
        get { return UIFont.systemFont(ofSize: Scale.width(18)) }
    }
    
    open class var size16: UIFont {
        get {return UIFont.systemFont(ofSize: Scale.width(16))}
    }
    
    open class var size16Medium: UIFont {
        get {return UIFont(name: "PingFangSC-Medium", size: 16) ?? UIFont.size16}
    }
    open class var size14Medium: UIFont {
        get {return UIFont(name: "PingFangSC-Medium", size: 14) ?? UIFont.size14}
    }
    
    open class var size18Medium: UIFont {
        get {return UIFont(name: "PingFangSC-Medium", size: 18) ?? UIFont.size18}
    }
    
    open class var size20Medium: UIFont {
        get {return UIFont(name: "PingFangSC-Medium", size: 20) ?? UIFont.size18}
    }
}
