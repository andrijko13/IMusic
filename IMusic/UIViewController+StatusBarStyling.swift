//
//  UIView+StatusBarStyling.swift
//  Autobon
//
//  Created by Andriy Suden on 8/16/17.
//  Copyright © 2017 Autobon. All rights reserved.
//

import UIKit

extension UIViewController {
    func setStatusBarColor(_ color: Styler.ColorKey) {
        let app = UIApplication.shared
        let statusBarHeight = app.statusBarFrame.size.height
        
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: statusBarHeight)
        let statusBarView = UIView.init(frame: rect)
        statusBarView.backgroundColor = Styler.main.colorForKey(color)
        self.view.addSubview(statusBarView)
    }
}
