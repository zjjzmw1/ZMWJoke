//
//  Tool.swift
//  swiftDemo1
//
//  Created by xiaoming on 16/3/7.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import Foundation
import UIKit

public class Tool {
    
    /**
     封装的UILabel 初始化
     
     - parameter frame:      大小位置
     - parameter textString: 文字
     - parameter font:       字体
     - parameter textColor:  字体颜色
     
     - returns: UILabel
     */
    public class func initALabel(frame:CGRect,textString:String,font:UIFont,textColor:UIColor) -> UILabel {
        let aLabel = UILabel()
        aLabel.frame = frame
        aLabel.backgroundColor = UIColor.clear
        aLabel.text = textString
        aLabel.font = font
        aLabel.textColor = textColor
//        aLabel.sizeToFit()
        
        return aLabel
    }
    
    /**
     封装的UIButton 初始化
     
     - parameter frame:       位置大小
     - parameter titleString: 按钮标题
     - parameter font:        字体
     - parameter textColor:   标题颜色
     - parameter bgImage:     按钮背景图片
     
     - returns: UIButton
     */
    public class func initAButton(frame:CGRect ,titleString:String, font:UIFont, textColor:UIColor, bgImage:UIImage) -> UIButton {
        let aButton = UIButton()
        aButton.frame = frame
        aButton.backgroundColor = UIColor.clear
        aButton .setTitle(titleString, for: UIControlState.normal)
        aButton .setTitleColor(textColor, for: UIControlState.normal)
        aButton.titleLabel?.font = font
        if bgImage != nil {
            aButton .setBackgroundImage(bgImage, for: UIControlState.normal)
        }
        
        return aButton
    }
    
}
