//
//  Textfield_extenson.swift
//  UTOOS
//
//  Created by Frekle on 2017/8/2.
//  Copyright © 2017年 Wang. All rights reserved.
//

import UIKit

extension UITextField {
    
    public convenience init(placeholder: String, textColor: UIColor, font: UIFont) {
        self.init()
        self.textColor = textColor
//        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.foregroundColor:textColor])
        self.placeholder = placeholder
        self.font = font
        clearButtonMode = .whileEditing
    }
    
    public convenience init(placeholder: String, leftImageView: UIImageView) {
        self.init(placeholder: placeholder, textColor: UIColor.placeholder, font: UIFont.size14)
        leftView = leftImageView
        leftViewMode = .always
        clearButtonMode = .whileEditing
    }
    public convenience init(placeholder: String, rightImageView: UIImageView) {
        self.init(placeholder: placeholder, textColor: UIColor.placeholder, font: UIFont.size14)
        leftView = rightImageView
        leftViewMode = .always
        clearButtonMode = .whileEditing
    }
}
