//
//  UIScrollView+MaxSubview.swift
//  Autobon
//
//  Created by Andriy Suden on 8/16/17.
//  Copyright © 2017 Autobon. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviewAtBottomOfAllSubviews(view:UIView){
        var maxY = CGFloat(0)
        for subview in self.subviews{
            if maxY < subview.frame.maxY{
                maxY = subview.frame.maxY
            }
        }
        
        view.frame.origin.y = maxY + 20
        self.addSubview(view)
    }
}

extension UIScrollView{
    func resizeContentSize(){
        
        var height: CGFloat = 20.0 // padding
        for view in self.subviews{
            height += (view.frame.size.height + 20)
        }
        
        self.contentSize = CGSize.init(width: UIScreen.main.bounds.size.width, height: height)
        
    }
}
