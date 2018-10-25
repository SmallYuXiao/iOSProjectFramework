//
//  Global.swift
//  U17
//
//  Created by charles on 2017/10/24.
//  Copyright © 2017年 None. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import MJRefresh
//当前系统版本
let kSystemVersion = (UIDevice.current.systemVersion as NSString).floatValue
extension UIColor {
    class var background: UIColor {
        return UIColor.rgb(242, 242, 242)
    }
    
    class var theme: UIColor {
        return UIColor.rgb(29, 221, 43)
        
    }
    class var MineColor: UIColor {
        return UIColor.rgb(73, 130, 228)
    }
}
extension String {
    static let searchHistoryKey = "searchHistoryKey"
    static let sexTypeKey = "sexTypeKey"
    /***👋 厂商标识 👋**/
    static let userClientId = "2018071215364156"
} 

extension NSNotification.Name {
    static let USexTypeDidChange = NSNotification.Name("USexTypeDidChange")
}
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let Window = UIApplication.shared.windows.first
// 状态栏高度
let kStatuHeight : CGFloat = 20
// 导航栏高度
// 判断是否为 iPhone X
let isIphoneX = screenHeight >= 812 ? true : false
let kNavigationBarHeight :CGFloat =  isIphoneX ? 68 : 44
// 渐变色色组
let kLowOrangeColor = UIColor(red: colorValue(73), green:colorValue(130), blue: colorValue(228), alpha: 1.0)
let kHighOrangeColor = UIColor(red: colorValue(237), green:colorValue(105), blue: colorValue(57), alpha: 1.0)
let kGradientColors: [CGColor] = [kLowOrangeColor.cgColor, kHighOrangeColor.cgColor]
func colorValue(_ value : CGFloat) -> CGFloat {
    return value / 255.0
}
// 时间戳转日期
/**
 *   let time = timeStampToString(timeStamp: model?.start_time?.description ?? "0", format: "HH:mm MM月dd日")
 titleLab.text = timeStampToString(timeStamp: model?.start_time?.description ?? "0", format: "yyyy年MM月dd日")
 
 */
func timeStampToString(timeStamp:String,format:String)->String {
    
    let string = NSString(string: timeStamp)
    
    let timeSta:TimeInterval = string.doubleValue
    let dfmatter = DateFormatter()
    dfmatter.dateFormat = format
    let date = NSDate(timeIntervalSince1970: timeSta)
    return dfmatter.string(from: date as Date)
}

var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}
//MARK: Kingfisher
extension Kingfisher where Base: ImageView {
    @discardableResult
    public func setImage(urlString: String?, placeholder: Placeholder? = UIImage(named: "")) -> RetrieveImageTask {
        return setImage(with: URL(string: urlString ?? ""),
                        placeholder: placeholder,
                        options:[.transition(.fade(0.5))])
    }
}
extension Kingfisher where Base: UIButton {
    @discardableResult
    public func setImage(urlString: String?, for state: UIControlState, placeholder: UIImage? = UIImage(named: "normal_placeholder_h")) -> RetrieveImageTask {
        return setImage(with: URL(string: urlString ?? ""),
                        for: state,
                        placeholder: placeholder,
                        options: [.transition(.fade(0.5))])
    }
}
//MARK: SnapKit
extension ConstraintView {
    var usnp: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}
extension UICollectionView {
    func reloadData(animation: Bool = true) {
        if animation {
            reloadData()
        } else {
            UIView .performWithoutAnimation {
                reloadData()
            }
        }
    }
}
//MARK: swizzledMethod
extension NSObject {

    static func swizzleMethod(_ cls: AnyClass, originalSelector: Selector, swizzleSelector: Selector){
        
        let originalMethod = class_getInstanceMethod(cls, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(cls, swizzleSelector)!
        let didAddMethod = class_addMethod(cls,
                                           originalSelector,
                                           method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(cls,
                                swizzleSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}

extension UIApplication {
    
    private static let u_initialize: Void = {
        UINavigationController.u_initialize
        if #available(iOS 11.0, *) {
            UINavigationBar.u_initialize
        }
    }()
    
    open override var next: UIResponder? {
        UIApplication.u_initialize
        return super.next
    }
}

