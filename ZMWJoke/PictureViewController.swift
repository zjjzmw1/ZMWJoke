//
//  PictureViewController.swift
//  ZMWJoke
//
//  Created by xiaoming on 16/8/28.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import UIKit

class PictureViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "图片"
        
        let imageV : UIImageView = UIImageView.init(frame: CGRect.init(x: 10, y: 80, width: 100, height: 100))
        imageV.backgroundColor = UIColor.red
        self.view.addSubview(imageV)
        
        let url : URL = NSURL.init(string: "http://zhangmingwei.qiniudn.com/1-130422091545.jpg") as! URL
        imageV.kf_setWebURL(url)

    }


}
