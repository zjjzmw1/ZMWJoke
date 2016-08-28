//
//  GlobalDefine.swift
//  swiftDemo1
//
//  Created by xiaoming on 16/3/7.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import Foundation
import UIKit

/// 是否是iOS9之后的系统
let kIsIOS9Later  =   (UIDevice.current.systemVersion as NSString).doubleValue >= 9.0
/// 是否是iPhone4
let kIsIphone4s   =   (UIScreen.main.bounds.size.width == 320)
/// 导航栏高度 64
let kNavBarHeight: CGFloat = 64.0
/// tabbar的高度 49
let kTabBarHeight: CGFloat = 49.0
/// 屏幕宽度
let kScreenWidth           = UIScreen.main.bounds.width
/// 屏幕高度
let kScreenHeight          = UIScreen.main.bounds.height

let kCalendar              = NSCalendar.current
let kDateFormatter         = DateFormatter()
/// 自定义字体
let kMyFontName            = "BebasNeue"

// -------------------------------颜色定义-----------------------------------------
