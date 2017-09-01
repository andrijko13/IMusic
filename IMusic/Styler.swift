//
//  Styler.swift
//  Autobon
//
//  Created by Andriy Suden on 8/16/17.
//  Copyright © 2017 Autobon. All rights reserved.
//

import UIKit

class Styler: NSObject {
    
    static var main: Styler = Styler.init()
    
    private override init() {
        
    }
    
    enum ColorKey: String {
        case lightGreen
        case darkGray
        case lightGray
        case lightGray2
        case tabBarGray
        case warningOrange
        case errorRed
        case black
        case white
        case lightBlue
    }
    
    func colorForKey(_ key: ColorKey) -> UIColor {
        switch key {
        case .lightGreen:
            return UIColor.init(red: 13.0/255.0, green: 255.0/255.0, blue: 82.0/255.0, alpha: 1.0)
        case .darkGray:
            return UIColor.init(red: 44.0/255.0, green: 44.0/255.0, blue: 44.0/255.0, alpha: 1.0)
        case .lightGray:
            return UIColor.init(red: 57.0/255.0, green: 57.0/255.0, blue: 56.0/255.0, alpha: 1.0)
        case .lightGray2:
            return UIColor.init(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
        case .tabBarGray:
            return UIColor.init(red: 47.0/255.0, green: 47.0/255.0, blue: 47.0/255.0, alpha: 1.0)
        case .warningOrange:
            return UIColor.init(red: 255.0/255.0, green: 119.0/255.0, blue: 48.0/255.0, alpha: 1.0)
        case .errorRed:
            return UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 48.0/255.0, alpha: 1.0)
        case .white:
            return UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        case .black:
            return UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        case .lightBlue:
            return UIColor.init(red: 85.0/255.0, green: 128.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        }
    }
}
