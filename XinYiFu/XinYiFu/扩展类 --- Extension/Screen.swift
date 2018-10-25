//
//  Screen.swift
//  UTOO
//
//  Created by Frekle on 2017/2/16.
//  Copyright © 2017年 Lenny. All rights reserved.
//

import UIKit

struct Margin {
    var left: CGFloat {
        return Scale.width(10)
    }
    
    var right: CGFloat {
        return Scale.width(10)
    }
}

struct Screen {
    
    static var bounds: CGRect {
        return UIScreen.main.bounds
    }
    
    static var center: CGPoint {
        return CGPoint(x: width / 2, y: height / 2)
    }
    
    static var size: CGSize {
        return Screen.bounds.size
    }
    
    static var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static var margin = Margin()
    
    static var height: CGFloat {
        return Screen.size.height
    }
    
    static var scale: CGFloat {
        return UIScreen.main.scale
    }
    
    static var onePX: CGFloat {
        return 1 / Screen.scale
    }
    
    static let navBarHeight: CGFloat = 64
    
    static let tabBarHeight: CGFloat = 49
    
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    static let carBottomViewHeight: CGFloat = Scale.height(55)
    
    static let sectionOffset: CGFloat = Scale.height(5)
}
