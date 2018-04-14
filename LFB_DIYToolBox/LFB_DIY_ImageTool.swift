//
//  LFB_DIY_ImageTool.swift
//  LFB_DIYToolBox
//
//  Created by JD on 2018/4/13.
//  Copyright © 2018年 JD. All rights reserved.
//

import UIKit
import Foundation
import Accelerate

public extension UIImage{

// MARK ---------------------------------  类方法  ---------------------------------
    
    ///生成指定颜色的图片（ 这里生成的图片是纯色的图片 ）
    ///
    /// - Parameters:
    ///   - color: 指定颜色
    ///   - rect: 生成的图片大小
    /// - Returns: 返回图片
   public static func DIY_image_createImage(withColor color:UIColor ,rect:CGRect = CGRect.init(x: 0.0, y: 0.0, width: 100.0, height: 100.0)) -> UIImage{
        
        if(UIScreen.main.scale > 1){ //选用不同的context  让图片不模糊
            UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        }else{
            UIGraphicsBeginImageContext(rect.size)
        }
        
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let newimage:UIImage =  UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newimage
    }
    
    /// 将提供的 View 生成一张图片
    ///
    /// - Parameter aView: 提供的 View
    /// - Returns: view的照片
    public static func DIY_image_creatImage(formView aView:UIView) -> UIImage{
        if(UIScreen.main.scale > 1){ //选用不同的context  让图片不模糊
            UIGraphicsBeginImageContextWithOptions(aView.bounds.size, false, UIScreen.main.scale)
        }else{
            UIGraphicsBeginImageContext(aView.bounds.size)
        }
        aView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return viewImage
    }
    
    
// MARK ---------------------------------  对象方法  ---------------------------------
    
    /// 虚化称高斯模糊图片
    ///
    /// - Parameter blurNum: 调节值
    public func DIY_image_makeGaussBlur(withBlurNum blurNum:CGFloat) -> UIImage?{
        
        var blur:CGFloat = 0.5
        if blurNum <= 1 && blurNum > 0{
            blur = blurNum
        }
        
        var boxSize: NSInteger  = (blur * 40).nsinteger()
        boxSize = boxSize - (boxSize % 2) + 1;
        
        let img:CGImage = self.cgImage!
        
        var inbuffer = vImage_Buffer.init()
        var outBuffer = vImage_Buffer.init()
        
        var err = vImage_Error.init()
        
        let inProvider:CGDataProvider = img.dataProvider!
        let inBitmapData:CFData = inProvider.data!
        
        inbuffer.width = vImagePixelCount(img.width)
        inbuffer.height = vImagePixelCount(img.height)
        inbuffer.rowBytes = img.bytesPerRow
        inbuffer.data = UnsafeMutableRawPointer.init(mutating: CFDataGetBytePtr(inBitmapData))
        
        if let pixelBuffer:UnsafeMutableRawPointer =  malloc(img.bytesPerRow * img.height){
            
            outBuffer.data = pixelBuffer
            outBuffer.width = vImagePixelCount(img.width)
            outBuffer.height = vImagePixelCount(img.height)
            outBuffer.rowBytes = img.bytesPerRow
            
            err = vImageBoxConvolve_ARGB8888(&inbuffer, &outBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
            
            Dlog_ERR(err)
            
            let colorspace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
            
            let ctx:CGContext = CGContext.init(data: outBuffer.data, width: Int(outBuffer.width), height: Int(outBuffer.height), bitsPerComponent: 8, bytesPerRow:  outBuffer.rowBytes, space: colorspace, bitmapInfo: img.bitmapInfo.rawValue)!
            let newImage = UIImage.init(cgImage:ctx.makeImage()!)
            //clear up
            free(pixelBuffer)
            return newImage
        }else{
            Dlog_ERR( "高斯模糊转换出错")
        }
        return nil
    }

    /// 改变图片的颜色
    ///
    /// - Parameter color: 目标颜色
    /// - Returns: 修改颜色之后的图片
    public func DIY_image_blending(withColor color:UIColor, usingChannel: Bool = true) -> UIImage{
        var Galpha:CGFloat = 1
        if usingChannel {
            Galpha = color.cgColor.alpha
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        let rect:CGRect = CGRect.init(x: 0, y: 0, width:self.size.width ,height: self.size.height)
        UIRectFill(rect)
        self.draw(in: rect, blendMode: CGBlendMode.overlay, alpha: Galpha)
        self.draw(in: rect, blendMode: CGBlendMode.destinationIn, alpha: Galpha)
        let newimage:UIImage =  UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newimage
    }
    
    /// 添加 水印图片  在一张画布上画两次
    ///
    /// - Parameters:
    ///   - withMaskSize: 水印的位置
    ///   - maskImage: 水印图片
    /// - Returns: 返回绘制好的图片
    public func DIY_image_addWaterMask(withMaskRect rect:CGRect,maskImage:UIImage) -> UIImage {
        
        if(UIScreen.main.scale > 1){ //选用不同的context,适用不同的@2x／@3x 的屏幕。让图片不模糊
            UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        }else{
            UIGraphicsBeginImageContext(self.size)
        }
        self.draw(in: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: self.size))
        maskImage.draw(in:rect)
        let newimage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newimage
    }
    
    /// 截切指定图片上的某部分
    ///
    /// - Parameter rect: 指定的 rect
    /// - Returns: 返回裁剪的图片
    public func dropImage(withRect rect: CGRect) -> UIImage {
        let scale:CGFloat = UIScreen.main.scale
        var dianRect:CGRect = CGRect.init(x: rect.origin.x*scale, y: rect.origin.y*scale, width: rect.size.width*scale, height: rect.size.height*scale)
        if dianRect.width > (self.cgImage?.width.cgfloat())! ||  dianRect.height > (self.cgImage?.height.cgfloat())!{
            dianRect = rect
        }
        
        if(UIScreen.main.scale > 1){ //选用不同的context,适用不同的@2x／@3x 的屏幕。让图片不模糊
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
        }else{
            UIGraphicsBeginImageContext(size)
        }
        let newCgImage:CGImage = (self.cgImage?.cropping(to: dianRect))!
        UIGraphicsEndImageContext();
        return UIImage.init(cgImage: newCgImage, scale: scale, orientation: UIImageOrientation.up)
    }
    
    //改变图片的尺寸  注意 这只能返回 8 位通道的上下文  即 矢量图可以使用该函数进行放大和缩小
    ///
    /// - Parameters:
    ///   - size: 指定的大小
    ///   - xGap: 横向间隙
    ///   - yGap: 总想着间隙
    /// - Returns: 返回图片
    public func imageSizeToInBit8(size: CGSize, xGap: CGFloat = 0, yGap: CGFloat = 0) -> UIImage {
        
        if(UIScreen.main.scale > 1){ //选用不同的context,适用不同的@2x／@3x 的屏幕。让图片不模糊
            UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        }else{
            UIGraphicsBeginImageContext(size)
        }
        self.draw(in: CGRect.init(x: xGap, y: yGap, width: CGFloat(Int(size.width)-Int(xGap*2.0)), height: CGFloat(Int(size.height)-Int(yGap*2.0))))
        let newimage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newimage
    }
    
}


