//
//  LoginViewController.swift
//  ZMWJoke
//
//  Created by xiaoming on 16/8/28.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "登录"
        self.view.backgroundColor = UIColor.lightGray

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)

    }
}
