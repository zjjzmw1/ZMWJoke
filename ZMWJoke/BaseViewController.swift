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
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

    
    }

    
}
