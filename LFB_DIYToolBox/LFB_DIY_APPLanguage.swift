//
//  LFB_DIY_APPLanguage.swift
//  LFB_DIYToolBox
//
//  Created by JD on 2018/4/13.
//  Copyright © 2018年 JD. All rights reserved.
//

import UIKit

fileprivate let userDefaultStr: String = "LFB_DIY_LFB_DIY_LaunageType"

/// 语言类型
///
/// - EN: 英文
/// - CH: 中文
/// - SP: 西班牙语
public enum LFB_DIY_LaunageType: String {
    case EN = "English:en"        //英文
    case CH = "中文:zh-Hans"       //中文
    case SP = "Español:sp"        //西班牙语
    case RU = "русский:ru"        //俄罗斯语
    
    static fileprivate func instance(str: String?) -> LFB_DIY_LaunageType {
        if let raw = str {
            return LFB_DIY_LaunageType.init(rawValue: raw)!
        }
        
        //如果手机是中文系统 ， 输出中文
        let obj = Locale.preferredLanguages.first!
        if(obj.contains("zh-Hans")){
            return LFB_DIY_LaunageType.CH
        }
        
        //其余国家的语言 ， 默认输出英文
        return LFB_DIY_LaunageType.EN
    }
    
    func LaunageName() -> String{
        return String.init(describing: self.rawValue.split(separator: ":").first)
    }
    
    func LaunageTag() -> String{
        return String.init(describing: self.rawValue.split(separator: ":").last)
    }
    
    static func setAppLanguage(type: LFB_DIY_LaunageType){
        UserDefaults.standard.set(type.rawValue, forKey: userDefaultStr)
        UserDefaults.standard.synchronize()
    }
    static func appLanguage() -> LFB_DIY_LaunageType{
        //默认情况使用当前APP使用的语言。当没有任何设置的时候， 如果有
        guard let obj = UserDefaults.standard.object(forKey: userDefaultStr) as? String else {
            return LFB_DIY_LaunageType.instance(str: nil)
        }
        return LFB_DIY_LaunageType.instance(str: obj)
    }
}

func APPLocal(_ A: String) -> String{
    var s:String = "本地语言设置失败"
    let type:LFB_DIY_LaunageType = LFB_DIY_LaunageType.appLanguage()
    let path = Bundle.main.path(forResource: type.LaunageTag(), ofType: "lproj")!
    if let bundle = Bundle.init(path: path){
        s = (bundle.localizedString(forKey: A, value: "", table: nil))
    }
    return s
}


