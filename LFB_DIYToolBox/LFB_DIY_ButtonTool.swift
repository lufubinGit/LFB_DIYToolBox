//
//  LFB_DIY_ButtonTool.swift
//  LFB_DIYToolBox
//
//  Created by JD on 2018/4/13.
//  Copyright © 2018年 JD. All rights reserved.
//

import UIKit
import Foundation

public protocol LFB_DIY_ToolBox  {
}

public typealias BtnAction = (UIButton)->()


// 点击事件
public extension UIButton {
    /// 处理按钮点击放大事件
    @objc fileprivate func pressedEvent(){
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        }
        self.delayAction(atime: 3.0) {
            self.unpressedEvent()
        }
    }
    @objc fileprivate func unpressedEvent(){
        func unpressedEvent(){
            UIView.animate(withDuration: 0.3) {
                self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }
        }
    }
    
    @objc dynamic fileprivate func touchUpInsideBtnAction(btn: UIButton) {
        if let actionDic = self.actionDic  {
            if let touchUpInSideAction = actionDic.object(forKey: String.init(describing: UIControlEvents.touchUpInside.rawValue)) as? BtnAction{
                touchUpInSideAction(self)
            }
        }
    }

    @objc dynamic fileprivate func touchUpOutsideBtnAction(btn: UIButton) {
        if let actionDic = self.actionDic  {
            if let touchUpOutsideBtnAction = actionDic.object(forKey: String.init(describing: UIControlEvents.touchUpOutside.rawValue)) as? BtnAction{
                touchUpOutsideBtnAction(self)
            }
        }
    }
    
    @objc dynamic fileprivate func touchDragOutsideBtnAction(btn: UIButton) {
        if let actionDic = self.actionDic  {
            if let touchUpOutsideBtnAction = actionDic.object(forKey: String.init(describing: UIControlEvents.touchDragOutside.rawValue)) as? BtnAction{
                touchUpOutsideBtnAction(self)
            }
        }
    }

    @objc dynamic fileprivate func touchDragInsideBtnAction(btn: UIButton) {
        if let actionDic = self.actionDic  {
            if let touchUpOutsideBtnAction = actionDic.object(forKey: String.init(describing: UIControlEvents.touchDragInside.rawValue)) as? BtnAction{
                touchUpOutsideBtnAction(self)
            }
        }
    }

    @objc dynamic fileprivate func touchDownRepeatBtnAction(btn: UIButton) {
        if let actionDic = self.actionDic  {
            if let touchUpOutsideBtnAction = actionDic.object(forKey: String.init(describing: UIControlEvents.touchDownRepeat.rawValue)) as? BtnAction{
                touchUpOutsideBtnAction(self)
            }
        }
    }

    @objc dynamic fileprivate func touchDownBtnAction(btn: UIButton) {
        if let actionDic = self.actionDic  {
            if let touchUpOutsideBtnAction = actionDic.object(forKey: String.init(describing: UIControlEvents.touchDown.rawValue)) as? BtnAction{
                touchUpOutsideBtnAction(self)
            }
        }
    }

    @objc dynamic fileprivate func touchDragEnterBtnAction(btn: UIButton) {
        if let actionDic = self.actionDic  {
            if let touchUpOutsideBtnAction = actionDic.object(forKey: String.init(describing: UIControlEvents.touchDragEnter.rawValue)) as? BtnAction{
                touchUpOutsideBtnAction(self)
            }
        }
    }

    @objc dynamic fileprivate func touchDragExitBtnAction(btn: UIButton) {
        if let actionDic = self.actionDic  {
            if let touchUpOutsideBtnAction = actionDic.object(forKey: String.init(describing: UIControlEvents.touchDragExit.rawValue)) as? BtnAction{
                touchUpOutsideBtnAction(self)
            }
        }
    }

    @objc dynamic fileprivate func touchCancelBtnAction(btn: UIButton) {
        if let actionDic = self.actionDic  {
            if let touchUpOutsideBtnAction = actionDic.object(forKey: String.init(describing: UIControlEvents.touchCancel.rawValue)) as? BtnAction{
                touchUpOutsideBtnAction(self)
            }
        }
    }
    
}



/**
 *  按钮的类别
 */
public enum FBButtonType{
    case ImageLeft    //图片在左边
    case ImageTop     //图片在上方
    case ImageRight   //图片在右边
    case ImageBottom  //图片在下边
}

extension UIButton{
   ///  gei button 添加一个属性 用于记录点击tag
   private struct AssociatedKeys{
      static var actionKey = "actionKey"
   }
    
    @objc dynamic var actionDic: NSMutableDictionary? {
        set{
            objc_setAssociatedObject(self,&AssociatedKeys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let dic = objc_getAssociatedObject(self, &AssociatedKeys.actionKey) as? NSDictionary{
                return NSMutableDictionary.init(dictionary: dic)
            }
            return nil
        }
    }
    
    // MARK ---------------------------------  类方法  ---------------------------------
    
    
    
    // MARK ---------------------------------  对象方法  ---------------------------------
    
    /// 给按钮添加block点击事件
    ///
    /// - Parameter forStatus: 指定状态
    @discardableResult
    @objc dynamic fileprivate func DIY_button_add(action:@escaping  BtnAction ,for controlEvents: UIControlEvents) -> UIButton{
        let eventStr = NSString.init(string: String.init(describing: controlEvents.rawValue))
        if let actions = self.actionDic {
            actions.setObject(action, forKey: eventStr)
            self.actionDic = actions
        }else{
            self.actionDic = NSMutableDictionary.init(object: action, forKey: eventStr)
        }
        
        switch controlEvents {
        case .touchUpInside:
            self.addTarget(self, action: #selector(touchUpInsideBtnAction), for: .touchUpInside)
        case .touchUpOutside:
            self.addTarget(self, action: #selector(touchUpOutsideBtnAction), for: .touchUpOutside)
        case .touchDragOutside:
            self.addTarget(self, action: #selector(touchDragOutsideBtnAction), for: .touchDragOutside)
        case .touchDragInside:
            self.addTarget(self, action: #selector(touchDragInsideBtnAction), for: .touchDragInside)
        case .touchDownRepeat:
            self.addTarget(self, action: #selector(touchDownRepeatBtnAction), for: .touchDownRepeat)
        case .touchDown:
            self.addTarget(self, action: #selector(touchDownBtnAction), for: .touchDown)
        case .touchDragEnter:
            self.addTarget(self, action: #selector(touchDragEnterBtnAction), for: .touchDragEnter)
        case .touchDragExit:
            self.addTarget(self, action: #selector(touchDragExitBtnAction), for: .touchDragExit)
        case .touchCancel:
            self.addTarget(self, action: #selector(touchCancelBtnAction), for: .touchCancel)
        default:
             fatalError("请添加 button 特有的事件状态")
        }
        return self
    }
   
    @discardableResult
    public func addTouchUpInsideBtnAction(_ action:@escaping BtnAction) -> UIButton{
        return self.DIY_button_add(action: action, for: .touchUpInside)
    }
    @discardableResult
    public func addTouchUpOutsideBtnAction(_ action:@escaping BtnAction) -> UIButton{
        return self.DIY_button_add(action: action, for: .touchUpOutside)
    }
    @discardableResult
    public func addTouchDragOutsideBtnAction(_ action:@escaping BtnAction) -> UIButton{
        return self.DIY_button_add(action: action, for: .touchDragOutside)
    }
    @discardableResult
    public func addTouchDragInsideBtnAction(_ action:@escaping BtnAction) -> UIButton{
        return self.DIY_button_add(action: action, for: .touchDragInside)
    }
    @discardableResult
    public func addTouchDownBtnAction(_ action:@escaping BtnAction) -> UIButton{
        return self.DIY_button_add(action: action, for: .touchDown)
    }
    @discardableResult
    public func addTouchDragEnterBtnAction(_ action:@escaping BtnAction) -> UIButton{
        return self.DIY_button_add(action: action, for: .touchDragEnter)
    }
    @discardableResult
    public func addTouchDragExitBtnAction(_ action:@escaping BtnAction) -> UIButton{
        return self.DIY_button_add(action: action, for: .touchDragExit)
    }
    @discardableResult
    public func addTouchCancelBtnAction(_ action:@escaping BtnAction) -> UIButton{
        return self.DIY_button_add(action: action, for: .touchCancel)
    }
    
    
    //按钮 点击时自动放大
   public func DIY_button_enlargeWhenClicked(){
        self.addTarget(self, action:#selector(pressedEvent), for: .touchUpInside)
        self.addTarget(self, action: #selector(unpressedEvent), for: .touchUpOutside)
    }
    
    //设置buton的文字和图片的位置
   public func DIY_button_setButtonLayout(type:FBButtonType, space:CGFloat,numLines:CGFloat = 1){
        let space:CGFloat = space
        
        self.imageEdgeInsets = UIEdgeInsets.zero
        self.titleEdgeInsets = UIEdgeInsets.zero
        // 1. 得到imageView和titleLabel的宽、高
        var imageWidth:CGFloat = self.imageView!.frame.size.width
        var imageHeight:CGFloat = self.imageView!.frame.size.height
        let labelWidth:CGFloat = self.titleLabel!.intrinsicContentSize.width
        let labelHeight:CGFloat = self.titleLabel!.intrinsicContentSize.height*numLines
        
        if type == .ImageTop || type == .ImageBottom{
            let scale:CGFloat = imageWidth/imageHeight
            if imageHeight > self.Height - labelHeight{
                if scale > 1 {
                    imageHeight = imageHeight - labelHeight - (scale-1)*imageHeight
                    imageWidth = imageHeight*scale
                }else{
                    imageHeight = imageHeight - labelHeight
                    imageWidth = imageHeight*scale
                }
                self.setImage(self.currentImage?.imageSizeToInBit8(size: CGSize.init(width: imageWidth
                    , height: imageHeight)), for: .normal)
            }
        }
        
        if(type == FBButtonType.ImageLeft){
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }else if(type == FBButtonType.ImageBottom){
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            self.titleEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWidth, 0, 0);
        }else if(type == FBButtonType.ImageTop){
            self.imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -imageHeight-space/2.0, 0);
        }else if(type == FBButtonType.ImageRight){
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth-space/2.0, 0, imageWidth+space/2.0);
        }
    }

}

