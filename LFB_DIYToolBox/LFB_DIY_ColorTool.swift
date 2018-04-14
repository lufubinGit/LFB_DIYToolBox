//
//  LFB_DIY_ColorTool.swift
//  LFB_DIYToolBox
//
//  Created by JD on 2018/4/13.
//  Copyright © 2018年 JD. All rights reserved.
//

import UIKit

public extension UIColor{
  
    public static func DIY_color_RandowColor()->UIColor{ //随机颜色
        return UIColor(red: CGFloat(arc4random()%40+70)/255.0, green:  CGFloat(arc4random()%180)/255.0, blue:  CGFloat(arc4random()%80+160)/255.0, alpha: 1.0)
    }
    
    public static func DIY_color_RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    /// 通过字符代码获取颜色
    ///
    /// - Parameter RGBA: 如 #FFFFFF 参数
    public convenience init(RGBA: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if RGBA.hasPrefix("#") {
            let hex:String  = RGBA.DIY_string_subString(start: 2, end: RGBA.count)
            let scanner:Scanner = Scanner.init(string: hex)
            var hexValue: UInt64 = 0
            if(scanner.scanHexInt64(&hexValue)){
                switch hex.count {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    Dlog("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                }
            }else {
                Dlog("Scan hex error")
            }
        } else {
            Dlog("Invalid RGB string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

