//
//  LFB_DIY_Common.swift
//  LFB_DIYToolBox
//
//  Created by JD on 2018/4/13.
//  Copyright © 2018年 JD. All rights reserved.
//

import UIKit
public let ScreenWidth:CGFloat = UIScreen.main.bounds.size.width
public let ScreenHeight:CGFloat = UIScreen.main.bounds.size.height
public let navHei:CGFloat = 64
public let tabHei:CGFloat = currentPhoneType == .iPhoneX ? 83 : 49
public let stateHei: CGFloat = currentPhoneType == .iPhoneX ? 39 : 0



public enum PhoneType:String{
    //iPhone
    case iPodTouch5 = "iPod Touch 5"
    case iPodTouch6 = "iPod Touch 6"
    case iPhone4 = "iPhone 4"
    case iPhone4s = "iPhone 4s"
    case iPhone5 = "iPhone 5"
    case iPhone5s = "iPhone 5s"
    case iPhone5c = "iPhone 5c"
    case iPhone5se = "iPhone 5se"
    case iPhone6 = "iPhone 6"
    case iPhone6s = "iPhone 6s"
    case iPhone6sP = "iPhone 6s Plus"
    case iPhone7 = "iPhone 7"
    case iPhone7P = "iPhone 7 Plus"
    case iPhone8 = "iPhone 8"
    case iPhone8P = "iPhone 8 Plus"
    case iPhoneX = "iPhone X"
    case iPhone678 = "iPhone 6.7.8"
    case iPhone678P = "iPhone 6P.7P.8P"
    case iPhone44s = "iPhone 4.4s"
    case iPhone55s = "iPhone 5.5s"
    
    //iPad
    case iPad2 = "iPad 2"
    case iPad3 = "iPad 3"
    case iPad4 = "iPad 4"
    case iPadAir = "iPad Air"
    case iPadAir2 = "iPad Air 2"
    case iPadMini = "iPad Mini"
    case iPadMini2 = "iPad Mini 2"
    case iPadMini3 = "iPad Mini 3"
    case iPadMini4 = "iPad Mini 4"
    case iPadPro = "iPad Pro"
    case AppleTV = "Apple TV"
    case Simulator = "Simulator"
    
    //默认
    case UnKnowDevice = "unknow"
}
// MARK - 获取当前手型号
public var currentPhoneType:PhoneType{
    get{
        var sysInfo = utsname.init()
        uname(&sysInfo)
        let machinMirror = Mirror.init(reflecting: sysInfo.machine)
        let identifier = machinMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else{return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
            
        case"iPod5,1":return PhoneType (rawValue: "iPod Touch 5")!
            
        case"iPod7,1":return PhoneType (rawValue: "iPod Touch 6")!
            
        case"iPhone3,1","iPhone3,2","iPhone3,3":return PhoneType (rawValue: "iPhone 4")!
            
        case"iPhone4,1":return PhoneType (rawValue: "iPhone 4s")!
            
        case"iPhone5,1","iPhone5,2":return PhoneType (rawValue: "iPhone 5")!
            
        case"iPhone5,3","iPhone5,4":return PhoneType (rawValue: "iPhone 5c")!
            
        case"iPhone6,1","iPhone6,2":return PhoneType (rawValue: "iPhone 5s")!
            
        case"iPhone7,2":return PhoneType (rawValue: "iPhone 6")!
            
        case"iPhone7,1":return PhoneType (rawValue: "iPhone 6 Plus")!
            
        case"iPhone8,1":return PhoneType (rawValue: "iPhone 6s")!
            
        case"iPhone8,2":return PhoneType (rawValue: "iPhone 6s Plus")!
            
        case"iPhone9,1":return PhoneType (rawValue: "iPhone 7")!
            
        case"iPhone9,2":return PhoneType (rawValue: "iPhone 7 Plus")!
            
        case"iPhone10,1", "iPhone10,4":return PhoneType (rawValue: "iPhone 8")!
            
        case"iPhone10,2","iPhone10,5":return PhoneType (rawValue: "iPhone 8 Plus")!
            
        case"iPhone10.3","iPhone10.6":return PhoneType (rawValue: "iPhone X")!
            
        case"iPad2,1","iPad2,2","iPad2,3","iPad2,4":return PhoneType (rawValue: "iPad 2")!
            
        case"iPad3,1","iPad3,2","iPad3,3":return PhoneType (rawValue: "iPad 3")!
            
        case"iPad3,4","iPad3,5","iPad3,6":return PhoneType (rawValue: "iPad 4")!
            
        case"iPad4,1","iPad4,2","iPad4,3":return PhoneType (rawValue: "iPad Air")!
            
        case"iPad5,3","iPad5,4":return PhoneType (rawValue: "iPad Air 2")!
            
        case"iPad2,5","iPad2,6","iPad2,7":return PhoneType (rawValue: "iPad Mini")!
            
        case"iPad4,4","iPad4,5","iPad4,6":return PhoneType(rawValue: "iPad Mini 2")!
            
        case"iPad4,7","iPad4,8","iPad4,9":return PhoneType(rawValue: "iPad Mini 3")!
            
        case"iPad5,1","iPad5,2":return PhoneType(rawValue: "iPad Mini 4")!
            
        case"iPad6,7","iPad6,8":return PhoneType(rawValue: "iPad Pro")!
            
        case"AppleTV5,3":return PhoneType(rawValue: "Apple TV")!
            
        case"i386","x86_64": do {
            if UIScreen.main.currentMode?.size == CGSize.init(width: 1125, height: 2436) {
                return PhoneType (rawValue: "iPhone X")!
            }else if UIScreen.main.currentMode?.size == CGSize.init(width: 750, height: 1334){
                return PhoneType (rawValue: "iPhone 6.7.8")!
                
            }else if UIScreen.main.currentMode?.size == CGSize.init(width: 1242, height: 2208){
                return PhoneType (rawValue: "iPhone 6P.7P.8P")!
                
            }else if UIScreen.main.currentMode?.size == CGSize.init(width: 640, height: 1136){
                return PhoneType (rawValue: "iPhone 5.5s")!
                
            }else if UIScreen.main.currentMode?.size == CGSize.init(width: 640, height: 960){
                
                return PhoneType (rawValue: "iPhone 4.4s")!
            }else{
                return PhoneType(rawValue: "Simulator")!
                
            }
            }
            
        default:return PhoneType (rawValue: "unknow")!
            
        }
    }
}

public extension LFB_DIY_ToolBox where Self: Any{
    /// 延时函数
    ///
    /// - Parameters:
    ///   - atime: 时间
    ///   - closures: 回调
    public func delayAction(atime:TimeInterval,closures: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + atime, execute:closures)
    }
    
    /// 延时函数
    ///
    /// - Parameters:
    ///   - atime: 时间
    ///   - closures: 回调
    public static func delayAction(atime:TimeInterval,closures: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + atime, execute:closures)
    }

    /// 通过反射获取对象所有的属性
    ///
    /// - Returns: 所有属性的一个数组
    public static func getAllVarsWithMirro()->[String]{
        let mirro = Mirror.init(reflecting: self)
        var pros: [String] = [String]()
        for item in mirro.children{
            if let itemProName = item.label{
                pros.append(itemProName)
            }
        }
        return pros
    }
    
}

public extension LFB_DIY_ToolBox where Self: AnyObject{
    public func delayAction(atime:TimeInterval,closures: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + atime, execute:closures)
    }
   public static func delayAction(atime:TimeInterval,closures: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + atime, execute:closures)
    }
}

extension NSObject:LFB_DIY_ToolBox {
    func delayAction(atime:TimeInterval,closures: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + atime, execute:closures)
    }
    static func delayAction(atime:TimeInterval,closures: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + atime, execute:closures)
    }
}


// MARK - 协议  *****************************************************

//协议then  用于将部分分散的代码放进一个花括号中
public protocol Then {}
extension Then where Self: Any {
    
    //Any 是值类型， inout的目的是为了将他们使用引用的方式传递。&A
    @discardableResult public func then_Any(_ remark:String? , block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
}


extension Then where Self: AnyObject {
    
    @discardableResult public func then(_ remark:String? , block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Then {}
public extension NSObject {
    
    /// 获取指定类的属性和属性值  返回一个以属性名的为键 属性值为值的 字典
    ///
    /// - Parameter filter: 需要过滤的属性
    /// - Returns: 返回对象的所有的属性的健值对
    public func classAllPorp(filter:NSArray) -> NSDictionary {
        var count: UInt32 = 0
        //获取类的属性列表,返回属性列表的数组,可选项
        let list = class_copyPropertyList(self.classForCoder, &count)
        Dlog("属性个数:\(count)")
        let propDic :NSMutableDictionary = NSMutableDictionary.init()
        for i in 0..<Int(count) {
            //根据下标获取属性
            let pty = list?[i]
            //获取属性的名称<C语言字符串>
            //转换过程:Int8 -> Byte -> Char -> C语言字符串
            let cName = property_getName(pty!)
            //转换成String的字符串
            let name:String = String(utf8String: cName)!
            if !filter.contains(name){
                propDic.setValue(self.value(forKey: name), forKey: name)
                print(name)
            }
        }
        free(list) //释放list
        return propDic
    }
    
    /// 计算字符宽度
    ///
    /// - Parameters:
    ///   - labelStr: 文字
    ///   - font: 字体
    ///   - height: 设定高度
    /// - Returns: 返回的字符串宽度
   public func getLabWidth(labelStr:String,font:UIFont,height:CGFloat) -> CGFloat {
        
        let statusLabelText: NSString = labelStr as NSString
        
        let size = CGSize.init(width: 900, height: height)
        
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : AnyObject], context:nil).size
        
        return strSize.width
    }
    
    
    /// 获取字符的高度 （同上）
    ///
    /// - Parameters:
    ///   - labelStr: <#labelStr description#>
    ///   - font: <#font description#>
    ///   - Width: <#Width description#>
    /// - Returns: <#return value description#>
   public func getLabHeight(labelStr:String,font:UIFont,Width:CGFloat) -> CGFloat{
        
        let statusLabelText: NSString = labelStr as NSString
        let size = CGSize.init(width: Width, height: 999)
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : AnyObject], context:nil).size
        return strSize.height
    }
    
    
    /// 获取字符的尺寸
    ///
    /// - Parameters:
    ///   - labelStr: 字符内容
    ///   - font: 大小
    /// - Returns: 尺寸
   public func  getLabelSize(labelStr:String,font:CGFloat)->CGSize{
        
        let W = self.getLabWidth(labelStr: labelStr, font: UIFont.systemFont(ofSize: font), height: 999) + 10
        let H = self.getLabHeight(labelStr: labelStr, font: UIFont.systemFont(ofSize: font), Width: 999) + 10
        
        return CGSize.init(width: W, height: H)
    }
    
}


