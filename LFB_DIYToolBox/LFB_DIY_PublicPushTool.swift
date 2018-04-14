//
//  LFB_DIY_PublicPushTool.swift
//  LFB_DIYToolBox
//
//  Created by JD on 2018/4/13.
//  Copyright © 2018年 JD. All rights reserved.
//

import UIKit


open class PublicPushTool: UIView {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var content: UILabel!
    @IBOutlet var icon: UIImageView!
    let bgView = UIView()
    
    public class func makePush(with content: String) {
        let head = Bundle.main.loadNibNamed("PublicPushToolXib",
                                            owner: PublicPushTool.self,
                                            options: nil)?.first as! PublicPushTool
        let contentH:CGFloat = UIView().getLabHeight(labelStr: content, font: head.content.font, Width: ScreenWidth - 40) + 10
        head.Height = (head.icon.Bottom + 10.0 * 2.0 + contentH) > 100 ? 100 : (head.icon.Bottom + 10.0 * 2.0 + contentH)
        let blue = UIColor.DIY_color_RGBA(r: 3, g: 31, b: 112, a: 1)
        head.backgroundColor = UIColor.white
        head.DIY_view_addBlurEffect(effStyle: .light)
        head.layer.masksToBounds = true
        head.layer.cornerRadius = 12
        
        head.layer.shadowColor = UIColor.DIY_color_RGBA(r:199,g:69,b:69,a:1).cgColor
        head.layer.shadowOffset = CGSize.init(width: 3.0, height: 3.0)
        
        
        head.nameLabel.textColor = blue
        head.nameLabel.text = "GP50ooooo"
        if let text = Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String{
            head.nameLabel.text = text
        }
        head.nameLabel.font = UIFont.systemFont(ofSize: 16)
        
        head.icon.layer.masksToBounds = true
        head.icon.layer.cornerRadius = 5
        
        head.content.text = content
        
        head.timeLabel.textColor = blue
        head.timeLabel.text = APPLocal("Now")
        head.timeLabel.font = UIFont.systemFont(ofSize: 14)
        
        head.frame = CGRect.init(x: 10, y: 10, width: ScreenWidth-20, height: head.Height)
        
        head.showPush()
        
        head.bgView.frame = head.frame
        head.bgView.backgroundColor = UIColor.clear
        head.bgView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        let path = UIBezierPath.init(roundedRect: head.bgView.bounds, cornerRadius: 12)
        
        head.bgView.layer.shadowPath = path.cgPath
        head.bgView.layer.shadowColor = UIColor.DIY_color_RGBA(r:50,g:50,b:50,a:1).cgColor
        head.bgView.layer.shadowOpacity = 0.8
        
        head.isUserInteractionEnabled = true
        let swip = UISwipeGestureRecognizer.init(target: head, action: #selector(disMiss))
        let pan = UIPanGestureRecognizer.init(target: head, action: #selector(disMiss))
        let tap = UITapGestureRecognizer.init(target: head, action:#selector(disMiss) )
        head.addGestureRecognizer(swip)
        head.addGestureRecognizer(tap)
        head.addGestureRecognizer(pan)
    }
    
    @objc fileprivate func disMiss(){
        UIView.animate(withDuration: 0.3, animations: {
            self.Y = self.Y - self.Height - 10
            self.bgView.Y = self.Y - self.Height - 10
        }, completion: { (bool) in
            self.removeFromSuperview()
            self.bgView.removeFromSuperview()
        })
        if let win = UIApplication.shared.windows.first {
            win.windowLevel = UIWindowLevelNormal
        }
        
    }
    
    fileprivate func showPush() {
        if let win = UIApplication.shared.windows.first {
            win.addSubview(self.bgView)
            win.addSubview(self)
            self.Y = self.Y - self.Height - 10
            self.bgView.frame = self.frame
            UIView.animate(withDuration: 0.3, animations: {
                self.Y = self.Y + self.Height + 10
                self.bgView.Y = self.Y + self.Height + 10
                
            }, completion: { (bool) in
            })
            
            //隐藏 状态栏
            win.windowLevel = UIWindowLevelStatusBar + 1
            NSObject.delayAction(atime: 5.0, closures: {  //5 秒中之后自动消除
                win.windowLevel = UIWindowLevelNormal
                self.disMiss()
            })
            
        }
    }
    
    
}

