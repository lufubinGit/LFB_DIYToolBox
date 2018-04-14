//
//  FBFootRefreshControl.swift
//  Telemetrica
//
//  Created by JD on 2018/3/5.
//  Copyright © 2018年 ru.sc72. All rights reserved.
//

import UIKit

class FBFootRefreshControl: UIView {
    
    enum FootRefreshStatu: String {
        case readyRefresh = "Pull up loading"
        case refreshing = "Loading..."
        case noMoreData = "No more data"
    }
    
    fileprivate var activity: UIActivityIndicatorView!
    
    fileprivate var statu: FootRefreshStatu!
    
    fileprivate var titleLabel: UILabel!
    
    fileprivate var startAction: (()->())? = nil
    
    fileprivate var endAction: (()->())? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.activity = UIActivityIndicatorView.init()
        self.statu = .readyRefresh
        self.titleLabel = UILabel.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func makeRefresh(start: @escaping ()->(), end:@escaping ()->()) {
        self.startAction = start
        self.endAction = end
        activity.color = UIColor.DIY_color_RGBA(r:50,g:50,b:50,a:1)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.DIY_color_RGBA(r:50,g:50,b:50,a:1)
        self.addSubview(self.activity)
        self.addSubview(self.titleLabel)
        laoutSubs(isActivity: false)
    }
    
    private func laoutSubs(isActivity: Bool){
        self.activity.frame = CGRect.init(x: 0, y: 0, width: self.Height*0.6, height: self.Height*0.6)
        titleLabel.text = APPLocal(self.statu.rawValue)
        let W = getLabWidth(labelStr: APPLocal(self.statu.rawValue), font: titleLabel.font, height: self.Height)
        self.titleLabel.frame = CGRect.init(x: 0, y: 0, width: W, height: self.Height)
        
        self.titleLabel.CenterY = self.Height/2.0
        if isActivity {
            self.titleLabel.CenterX = self.Width/2.0 + self.activity.Width/2.0
            self.activity.CenterX = self.Width/2.0 - self.titleLabel.Width/2.0
            self.activity.CenterY = self.Height/2.0
        }else{
            self.titleLabel.CenterX = self.CenterX
        }
    }
    
    func startRefresh(){
        self.statu = .refreshing
        self.startAction!()
        self.laoutSubs(isActivity: true)
        self.activity.startAnimating()
    }
    
    func noMoreData(){
        self.statu = .noMoreData
        self.laoutSubs(isActivity: false)
        self.activity.stopAnimating()

    }
    
    func resetStatu(){
        self.statu = .readyRefresh
        self.laoutSubs(isActivity: false)
        self.endAction!()
        self.activity.stopAnimating()
    }
    
    func refreshEnable() -> Bool {
        return !self.activity.isAnimating && self.statu != .noMoreData
    }
    
}
