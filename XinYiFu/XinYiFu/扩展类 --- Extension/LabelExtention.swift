//
//  UILabel_Ex.swift
//  JZB
//
//  Created by Lenny on 16/7/19.
//  Copyright © 2016年 Lenny. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    // 快速创建label
    convenience init(title: String = "", titleColor: UIColor, font: UIFont) {
        self.init()
        self.text = title
        self.textColor = titleColor
        self.font = font
    }
    
    func setAttributeString(str: String, border: Int) {
        let nameStr:NSMutableAttributedString = NSMutableAttributedString(string: str)
        let range = NSMakeRange(0, border)
        nameStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: range)
        let range2 = NSMakeRange(border, str.count-border)
        nameStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.green, range: range2)
        nameStr.addAttribute(NSAttributedStringKey.font, value: UIFont.size18, range: NSMakeRange(0, str.count))
        attributedText = nameStr
    }
    
    func contentSize(_ width:CGFloat) -> CGSize {
        
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineBreakMode = self.lineBreakMode
        paragraphStyle.alignment = self.textAlignment
        
        let str = self.text! as NSString
        let op = NSStringDrawingOptions.usesLineFragmentOrigin
        let contentFrame = str.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: op, attributes:[NSAttributedStringKey.font:self.font], context: nil)
        return contentFrame.size
    }
    
    func labelWithLineWide(lineW:CGFloat) {
        let str = NSMutableAttributedString.init(attributedString: self.attributedText!)
//        let str = NSMutableAttributedString.init(string: self.text!)
        str.addAttributes([NSAttributedStringKey.kern:lineW], range: NSRange.init(location: 0, length: str.length))
        self.attributedText = str
    }
    
    func labelMidLine() {
        
        let str = NSMutableAttributedString.init(attributedString: self.attributedText!)
//        let str = NSMutableAttributedString.init(string: self.text!)
        str.addAttributes([NSAttributedStringKey.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue | NSUnderlineStyle.patternSolid.rawValue], range: NSRange.init(location: 0, length: str.length))
        self.attributedText = str
    }
    
    func labelDownLine() {
     
        let str = NSMutableAttributedString.init(attributedString: self.attributedText!)
        str.addAttributes([NSAttributedStringKey.underlineStyle:NSNumber.init(value: NSUnderlineStyle.styleSingle.rawValue)], range: NSRange.init(location: 0, length: str.length))
        self.attributedText = str
    }
    
    func labelMidLine(lineStr:String) {
        
        let str = NSMutableAttributedString.init(attributedString: self.attributedText!)
//        let str = NSMutableAttributedString.init(string: self.text!)
        let range = NSString.init(string: self.text!).range(of: lineStr) as NSRange
        str.addAttributes([NSAttributedStringKey.strikethroughStyle:NSNumber.init(value: NSUnderlineStyle.styleSingle.rawValue)], range:range)
        self.attributedText = str
    }
    
    // 价格的后两位变小
    func priceFormat(smallFontDigits: Int = 2) {
        let font = UIFont.systemFont(ofSize: self.font.pointSize - Scale.height(6))
        guard let attributedStr = self.attributedText else{return}
        let str = NSMutableAttributedString(attributedString: attributedStr)
        str.addAttributes([NSAttributedStringKey.font: font], range: NSMakeRange(str.length - smallFontDigits, smallFontDigits))
        attributedText = str
    }
    
}
