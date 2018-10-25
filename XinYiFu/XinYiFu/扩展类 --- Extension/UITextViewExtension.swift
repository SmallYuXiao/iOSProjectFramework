//
//  UITextViewExtension.swift
//  U17
//
//  Created by 余潇逸 on 2018/8/16.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

extension UITextView {
    func heightForTextView(textView: UITextView, fixedWidth: CGFloat) -> CGFloat {
        let size = CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude)
        let constraint = textView.sizeThatFits(size)
        return constraint.height
    }
}
