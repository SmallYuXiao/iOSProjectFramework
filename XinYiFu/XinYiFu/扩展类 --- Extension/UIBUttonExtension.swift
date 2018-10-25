//
//  UIBUttonExtension.swift
//  U17
//
//  Created by 余潇逸 on 2018/8/4.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit


extension UIButton {

    
    func setAttributeString(str: String, border: Int, font: UIFont) {
        let nameStr:NSMutableAttributedString = NSMutableAttributedString(string: str)
        let range = NSMakeRange(0, border)
        nameStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(51, 51, 51), range: range)
        let range2 = NSMakeRange(border, str.count-border)
        nameStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(102, 102, 102), range: range2)
        nameStr.addAttribute(NSAttributedStringKey.font, value: font, range: NSMakeRange(0, str.count))
        setAttributedTitle(nameStr, for: .normal)
    }
    // 让uibutton的图片和文字上下垂直，注意图片宽度要大于文字宽度
    func verticalImageAndTitle(_ spacing: CGFloat) {
        let imageSize = imageView?.image?.size
        let titleSize = titleLabel?.frame.size
        let textSize = (titleLabel?.text ?? "").stringSize(font: UIFont.size14)
        let imageHeight = imageSize?.height ?? 0
        let imageWidth = imageSize?.width ?? 0
        let titleHeight = titleSize?.height ?? 0
        var titleWidth = titleSize?.width ?? 0
        let frameSize = CGSize(width: ceil(textSize.width), height: ceil(textSize.height))
        if (titleWidth + 0.5) < frameSize.width {
            titleWidth = frameSize.width
        }
        
        let totalHeight = imageHeight + titleHeight + spacing
        imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageHeight), 0.0, 0.0, -titleWidth)
        titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -(totalHeight - titleHeight), 0)
    }

    
    @objc func set(image anImage: UIImage?, title: String,
                   titlePosition: UIViewContentMode, additionalSpacing: CGFloat, state: UIControlState){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    
    
    private func positionLabelRespectToImage(title: String, position: UIViewContentMode,
                                             spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.stringSize(font:titleFont! )
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}
