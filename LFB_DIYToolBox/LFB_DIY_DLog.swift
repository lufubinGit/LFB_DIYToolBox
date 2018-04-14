//
//  LFB_DIY_DLog.swift
//  LFB_DIYToolBox
//
//  Created by JD on 2018/4/13.
//  Copyright © 2018年 JD. All rights reserved.
//

import UIKit
import Foundation

public func Dlog(_ item:@autoclosure ()->(Any),file:String = #file,function:String = #function,
                 line:Int = #line){
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName).\(line).\(function):\(item())")
        
    #else
        
    #endif
}

public func Dlog_ERR(_ item:@autoclosure ()->(Any),file:String = #file,function:String = #function,
                 line:Int = #line){
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName).\(line).\(function):\(item())")
        
    #else
        
    #endif
}
