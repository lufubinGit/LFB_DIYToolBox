//
//  LFB_DIY_StringTool.swift
//  LFB_DIYToolBox
//
//  Created by JD on 2018/4/13.
//  Copyright © 2018年 JD. All rights reserved.
//

import UIKit

// MARK: - 字符串的拓展
extension String {
    
    
    /* 将一个完整的字符 的每一个字母拆解出来 并放进一个数组中 */
    public func DIY_string_splitStringToArr() -> [String]{
        var index1 = self.startIndex
        var index2 :String.Index = self.endIndex
        var desStr :String
        var strArr: [String] = [String]()
        var strBuff :String = String()
        while index1 != index2{
            index2 = self.index(after: index1)
            desStr = self.substring(with: Range.init(uncheckedBounds: (lower: index1, upper: index2)))
            if(desStr.count != 0){
                strBuff.append(desStr)
                strArr.append(strBuff)
            }
            strBuff.removeAll()
            index1 = index2
            //检测是不是到头了
            if(index2 != self.endIndex){ //如果没有到头 那么就会继续执行程序
                index2 = self.index(after: index2)
            }else{  //说明到了最后了  这时候就应该将数据作为最后一个数组
                if(strBuff.count > 0){
                    strArr.append(strBuff)
                }
            }
        }
        return strArr
    }
    
    /// 删除字符串中的字符
    ///
    /// - Parameter charSet: 需要删除的字符的集合数组
    /// - Returns: 返回删除之后的字符
    public func DIY_string_removeChars(charSet:[String])->String{
        var newStr:String = String()
        let stringArr:[String] = self.DIY_string_splitStringToArr()
        for string in stringArr {
            var k:NSInteger = 0
            for fifterStr in charSet {
                if string == fifterStr {
                    k = k+1
                }
            }
            if k==0 { //木有一样的
                newStr.append(string)
            }
        }
        return newStr
    }
    
    /// 提取指定位置的字符串
    ///
    /// - Parameters:
    ///   - start: 起始位置（含）
    ///   - end: 结束位置（含）
    /// - Returns: 返回提取字符串
    public func DIY_string_subString(start:NSInteger,end:NSInteger) -> String{
        var desStr :String = String()
        if(start<=0||end>self.count||start>end){ //如果范围不对   就会返回一个空的字符串 表示没有获取到字符
            return ""
        }else{
            var strArr: [String] = self.DIY_string_splitStringToArr()
            for i in (start-1)..<end {
                desStr.append(strArr[i])
            }
        }
        return desStr
    }
    
    public func subStringAtIndex(index:NSInteger) -> String{
        return self.DIY_string_subString(start: index, end: index)
    }
}
