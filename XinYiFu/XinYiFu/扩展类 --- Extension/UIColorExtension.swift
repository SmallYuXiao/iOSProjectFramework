//
//  UIColorExtension.swift
//  U17
//
//  Created by charles on 2017/7/31.
//  Copyright © 2017年 charles. All rights reserved.
//

import UIKit

extension UIColor {
    //16进制的颜色值
    class func hexColor(_ rgbValue: Int) -> UIColor {
        let red   = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255.0
        let blue  = CGFloat(rgbValue & 0xFF) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    convenience init(r:UInt32 ,g:UInt32 , b:UInt32 , a:CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: a)
    }
    // rgb颜色
    class func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
    
    class var random: UIColor {
        return UIColor(r: arc4random_uniform(256),
                       g: arc4random_uniform(256),
                       b: arc4random_uniform(256))
    }
    
    func image() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    //颜色转成图片
    class func colorToImage(_ color:UIColor) -> UIImage {
        
        let rect:CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    class func hex(hexString: String) -> UIColor {
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        if cString.count < 6 { return UIColor.black }
        
        let index = cString.index(cString.endIndex, offsetBy: -6)
        let subString = cString[index...]
        if cString.hasPrefix("0X") { cString = String(subString) }
        if cString.hasPrefix("#") { cString = String(subString) }
        
        if cString.count != 6 { return UIColor.black }
        
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(r: r, g: g, b: b)
    }
    
    public class func hexStringToColor(hexString: String, alpha: CGFloat) -> UIColor {
        
        var cString: String = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if cString.characters.count < 6 {
            return UIColor.black
        }
        if cString.hasPrefix("0X") {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
        }
        if cString.hasPrefix("#") {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
        }
        if cString.characters.count != 6 {
            return UIColor.black
        }
        
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        if #available(iOS 10.0, *) {
            return UIColor(displayP3Red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
        } else {
            return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
        }
    }
    open class var dark: UIColor { get { return UIColor.rgb(51, 51, 51) } }
    
    open class var lightGray: UIColor { get { return UIColor.rgb(102, 102, 102) } }
    
    open class var grayText: UIColor { get { return UIColor.rgb(83, 83, 83) } }
    
    open class var placeholder: UIColor { get { return UIColor.rgb(153, 153, 153) } }
    
    open class var lightTheme: UIColor { get { return UIColor.rgb(255, 65, 0) } }
    
    open class var price: UIColor { get { return UIColor.hexColor(0xf37157) } }
    
    open class var top: UIColor { get { return UIColor.hexColor(0xde3031) } }
    
    open class var line: UIColor { get { return UIColor.hexColor(0xe1e1e1) } }
    
    open class var view: UIColor { get { return UIColor.hexColor(0xf0f1f2) } }
    
    
    
    
    
    open class var timeDesc: UIColor { get { return UIColor.hexColor(0x666666) } }
    
    open class var lightGreenDesc: UIColor { get { return UIColor.hexColor(0xc8ffe8) } }
    
    open class var backGray: UIColor { get { return UIColor.hexColor(0xf1f1f1) } }
    
    open class var wlGreen: UIColor { get { return UIColor.hexColor(0x1bbc9b) } }
    
    open class var yxGreen: UIColor { get { return UIColor.hexColor(0x84c351) } }
    
    open class var lightGreen: UIColor { get { return UIColor.hexColor(0x67ddab) } }
    
    open class var darkGreen: UIColor { get { return UIColor.hexColor(0x62d1a2) } }
    
    open class var pic: UIColor { get { return UIColor.hexColor(0xf1f1f1) }}
    
    open class var wlYellow: UIColor { get { return UIColor.hexColor(0xffc220)}}
    
    open class var wlBlack: UIColor { get { return UIColor.hexColor(0x333333)}}
    
    open class var wlRed: UIColor { get { return UIColor.hexColor(0xff2c2a) } }
    
    open class var wlGray: UIColor { get { return UIColor.hexColor(0xf3f2f0) } }
    
    open class var wlBlue: UIColor { get { return UIColor.hexColor(0x4d90e7) } }
    
    open class var wlPint: UIColor { get { return UIColor.hexColor(0xdb7093) } }
    
    open class var darkOrange: UIColor { get { return UIColor.hexColor(0xff6800) } }
    
    open class var lightOrange: UIColor { get { return UIColor.hexColor(0xff8938) } }
    
    open class var orangeDesc: UIColor { get { return UIColor.hexColor(0xFABE9B) } }
}


