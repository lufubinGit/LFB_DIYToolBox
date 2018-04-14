
//
//  LFB_DIY_ControllerTool.swift
//  LFB_DIYToolBox
//
//  Created by JD on 2018/4/13.
//  Copyright © 2018年 JD. All rights reserved.
//

import UIKit


/***  一站式 建立 tabBar  **/
extension UITabBarController {
    
    convenience init(titles:[String],titleColor:UIColor?,selectTitleColor:UIColor?,images:[UIImage],selectImages:[UIImage],chindViewControllers:[UIViewController]){
        
        self.init()
        for i in 0..<titles.count {
            
            let vc = chindViewControllers[i]
            if let color = titleColor {
                vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:color], for: .normal)
            }
            
            if let color = selectTitleColor {
                vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:color], for: .selected)
            }
            vc.title = titles[i]
            vc.tabBarItem.image = images[i]
            vc.tabBarItem.selectedImage = selectImages[i].withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            let nav = UINavigationController.init(rootViewController: vc)
            self.addChildViewController(nav)
        }
    }
}

extension UIViewController{
    
    typealias NavItemAction = (UIButton)->()
    func creatNavItem(with images:[UIImage]?,titles:[String]? = ["item1","item2"],actions:[NavItemAction])->(UIBarButtonItem,UIView){
        let itemW: CGFloat = 44
        let itemH: CGFloat = 44
        let bgViewH: CGFloat = 50
        let bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: itemW, height: itemH))
        bgView.isUserInteractionEnabled = true
        guard images != nil else{
            guard titles != nil else{
                fatalError("please enter image or title")
            }
            let titleCount = titles!.count
            bgView.frame = CGRect(x: 0, y: 0, width: bgViewH * titleCount.cgfloat(), height: itemH)
            for i in 0..<titles!.count {
                let titleButton = UIButton.init(type: .custom)
                titleButton.DIY_button_enlargeWhenClicked()
                titleButton.frame = CGRect.init(x: i.cgfloat()*bgViewH, y:0 , width: itemW, height: itemH)
                titleButton.setTitle(titles![i], for: .normal)
                titleButton.setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .highlighted)
                titleButton.setTitleColor(UIColor.white, for: .normal)
                titleButton.addTouchUpInsideBtnAction(actions[i])
                bgView.addSubview(titleButton)
            }
            return (UIBarButtonItem.init(customView: bgView),bgView)
        }
        
        let imageCount = images!.count
        bgView.frame = CGRect(x: 0, y: 0, width: bgViewH * imageCount.cgfloat(), height: itemH)
        for i in 0..<images!.count {
            let imageButton = UIButton.init(type: .custom)
            imageButton.DIY_button_enlargeWhenClicked()
            imageButton.frame = CGRect.init(x: i.cgfloat()*bgViewH, y:0 , width: itemW, height: itemH)
            imageButton.setImage(images![i], for: .normal)
            
            imageButton.setImage(images![i].DIY_image_blending(withColor: UIColor.white.withAlphaComponent(0.3)), for: .highlighted)
            imageButton.addTouchUpOutsideBtnAction(actions[i])

            bgView.addSubview(imageButton)
        }
        return (UIBarButtonItem.init(customView: bgView),bgView)
    }
}

