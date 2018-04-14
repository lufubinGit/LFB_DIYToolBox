//
//  LFB_DIY_Extension.swift
//  LFB_DIYToolBox
//
//  Created by JD on 2018/4/13.
//  Copyright © 2018年 JD. All rights reserved.
//

import UIKit

/// 针对数据类型转换 类型转换器
protocol LFB_TypeConvert{}
extension Int:LFB_TypeConvert{
    func string() -> String {
        return "\(self)"
    }
    
    func cgfloat() -> CGFloat {
        return CGFloat(self)
    }
}

extension CGFloat:LFB_TypeConvert{
    func string() -> String {
        return "\(self)"
    }
    
    func nsinteger() -> NSInteger {
        return NSInteger(self)
    }
}

extension String:LFB_TypeConvert{
    
    func nsinteger() -> NSInteger?{
        return NSInteger.init(self)
    }
    
    func cgfloat() -> CGFloat {
        return CGFloat((self as NSString).floatValue)
    }
}

extension UIView{
    
    public var Width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }
    
    public var Height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }
    
    public var X: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    
    public var Y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    
    public var CenterX: CGFloat{
        get{
            return self.center.x
        }
        set{
            var r = self.center
            r.x = newValue
            self.center = r
        }
    }
    
    public var CenterY: CGFloat{
        get{
            return self.center.y
        }
        set{
            var r = self.center
            r.y = newValue
            self.center = r
        }
    }
    
    public var Top: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            self.frame.origin.y = newValue
        }
    }
    
    public var Left: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            self.frame.origin.y = newValue
        }
    }
    
    public var Bottom: CGFloat{
        get{
            return self.frame.origin.y + self.frame.size.height
        }
        set{
            let buff:CGFloat = newValue - self.frame.size.height
            self.frame.origin.y = buff
        }
    }
    
    public var right: CGFloat{
        get{
            return self.frame.origin.x + self.frame.size.width
        }
        set{
            let buff:CGFloat = newValue-self.frame.size.width
            self.frame.origin.x = buff
        }
    }
    
    public var size: CGSize{
        get{
            return self.frame.size
        }
        set{
            var r = self.frame.size
            r = newValue
            self.frame.size = r
        }
    }
}


fileprivate var halowViewHandle:((UIView)->(Void))? = nil
extension UIView{
    
    
    /// 在一个 View 上添加 红色角标
    ///
    /// - Parameter color: 颜色
    public func DIY_view_addMyBgade(whih color:UIColor){
        let W:CGFloat = min(min(self.Width, self.Height),50.0) / 5.0
        let bgadeView = UIView.init(frame: CGRect.init(x: self.Width - W*2.0, y: W, width: W, height: W))
        bgadeView.backgroundColor = color
        self.addSubview(bgadeView)
        bgadeView.layer.cornerRadius = W/2.0
        bgadeView.layer.masksToBounds = true
        bgadeView.tag = 99999
    }
    
    /// 移除控件的角标
    public func DIY_view_removeMyBgade(){
        self.subviews.forEach { (view) in
            if view.tag == 99999{
                view.removeFromSuperview()
            }
        }
    }

    
    /// 移除所有的子视图
    public func DIY_view_removeAllSubView(){
        for item  in self.subviews{
            if item.isKind(of: UIView.classForCoder()){
                item.removeFromSuperview()
            }
        }
    }
    
    /// 给指定的角添加圆角
    ///
    /// - Parameters:
    ///   - conner: 圆角的位置 详细看UIRectCorner。
    ///   - cornerRadius: 圆角的大小
    public func DIY_view_clipCorner(atCorner conner:UIRectCorner,cornerRadius:CGFloat){
        let path = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: conner, cornerRadii: CGSize.init(width: cornerRadius, height:cornerRadius ))
        
        let maskLayer:CAShapeLayer = CAShapeLayer.init()
        maskLayer.backgroundColor = UIColor.clear.cgColor
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    /// 添加 毛玻璃 缺点：如果对象是变动的话， 就不能使用这个函数
    ///
    /// - Parameter effStyle: UIBlurEffectStyle类型
    public func DIY_view_addBlurEffect(effStyle:UIBlurEffectStyle, alhpa:CGFloat = 1.0){
        let eff:UIBlurEffect = UIBlurEffect.init(style: effStyle)
        let effView:UIVisualEffectView = UIVisualEffectView.init(frame: self.bounds)
        effView.alpha = alhpa
        effView.effect = eff
        self.addSubview(effView)
        self.sendSubview(toBack: effView)
    }
    
    /// 添加投影
    ///
    /// - Parameters:
    ///   - color: 投影的颜色
    ///   - gap: 投影到对象的距离
    ///   - shaadowImage: 投影使用的图片
    public func DIY_view_castShadow(color:UIColor,gap:CGFloat,shadowImage:UIImage?){
        let shawView:UIImageView = UIImageView.init(frame:CGRect.init(x: 0, y: 0, width: 50, height: 50))
        guard shadowImage != nil else {
            Dlog(errSecTimestampRevocationWarning)
            return
        }
        shawView.image = shadowImage?.DIY_image_blending(withColor:color)
        let superV:UIView = self.superview!
        superV.addSubview(shawView)
        superV.sendSubview(toBack: shawView)
        shawView.CenterX = self.CenterX
        shawView.Y = self.Bottom
        shawView.Width = self.Width*0.6
        shawView.Height = shawView.Width*0.2
        shawView.translatesAutoresizingMaskIntoConstraints = false
        superV.addConstraints([
            NSLayoutConstraint.init(item: shawView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 0.9, constant: 0),
            NSLayoutConstraint.init(item: shawView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: shawView, attribute: NSLayoutAttribute.width, multiplier: 0.15, constant: 0),
            NSLayoutConstraint.init(item: shawView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: shawView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant:gap)])
    }
    
    /// 创建一个漏洞图层
    ///
    /// - Parameters:
    ///   - hollowRect: 漏洞的大小
    ///   - BGColor: 涂层的背景颜色
    ///   - handle: 点击图层执行的动作  可以为空
    public func DIY_view_creatHollowInMap(hollowRect:CGRect,BGColor:UIColor,handle:@escaping (UIView)->(Void)){
        let bgView:UIView = UIView.init(frame: self.bounds)
        bgView.backgroundColor = BGColor
        //创建一个大的背景层
        let bigPath:UIBezierPath = UIBezierPath.init(rect: self.bounds)
        //创建一个小的图层
        let smallPath:UIBezierPath = UIBezierPath.init(rect: hollowRect)
        bigPath.append(smallPath)
        //创建显示图层
        let  showShareLayer:CAShapeLayer = CAShapeLayer.init()
        showShareLayer.path = bigPath.cgPath
        showShareLayer.fillRule = kCAFillRuleEvenOdd;//中间镂空的关键点 填充规则 这里采用的是奇偶规则
        showShareLayer.fillColor = UIColor.gray.cgColor;
        showShareLayer.opacity = 0.8;
        bgView.layer.mask = showShareLayer;
        bgView.layer.masksToBounds = false;
        self.addSubview(bgView)
        bgView.isUserInteractionEnabled = true
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(disMissHollowView))
        bgView.addGestureRecognizer(tap)
        halowViewHandle = handle
    }

    @objc private func disMissHollowView(tap:UITapGestureRecognizer){
        Dlog( "点击到了遮罩")
        if halowViewHandle != nil{
            halowViewHandle!(tap.view!)
        }
    }
    
}


