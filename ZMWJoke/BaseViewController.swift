//
//  BaseViewController.swift
//  ZMWJoke
//
//  Created by xiaoming on 16/8/27.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置导航栏颜色
        let naviBgImage = UIImage.imageWithColor(color: UIColor.white, size: CGSize.init(width: kScreenWidth, height: kNavBarHeight))
        navigationController?.navigationBar.setBackgroundImage(naviBgImage, for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    
        // 设置统一的背景颜色
        self.view.backgroundColor = UIColor.white
    
    }

    
}
