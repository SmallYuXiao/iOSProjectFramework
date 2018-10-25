//
//  UEmptyDataSet.swift
//  U17
//
//  Created by charles on 2017/11/28.
//  Copyright © 2017年 None. All rights reserved.
//

import Foundation
import EmptyDataSet_Swift
import UIKit

extension UIScrollView {
    
    private struct AssociatedKeys {
        static var uemptyKey: Void?
    }
    
    var uempty: UEmptyView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.uemptyKey) as? UEmptyView
        }
        set {
            self.emptyDataSetDelegate = newValue
            self.emptyDataSetSource = newValue
           objc_setAssociatedObject(self, &AssociatedKeys.uemptyKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

class UEmptyView: EmptyDataSetSource, EmptyDataSetDelegate {
    
    var image: UIImage?
    //也不知道这个是什么意思
    
    var allowShow: Bool = false
    var verticalOffset: CGFloat = -300
    
    
    private var tapClosure: (() -> Void)?
    
    init(image: UIImage? = UIImage(named: "网络不给力"), verticalOffset: CGFloat = 0, tapClosure: (() -> Void)?) {
        self.image = image
        self.verticalOffset = verticalOffset
        self.tapClosure = tapClosure
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return verticalOffset
    }
    
    internal func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return image
    }
    
    internal func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return allowShow
    }
    
    internal func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        guard let tapClosure = tapClosure else { return }
        tapClosure()
    }
    func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
        let defalt  = HYKNoSignalView()
        return defalt
    }

}




