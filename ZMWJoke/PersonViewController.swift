//
//  PersonViewController.swift
//  ZMWJoke
//
//  Created by xiaoming on 16/8/28.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import UIKit

class PersonViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "个人中心"

        let button = Tool.initAButton(frame: CGRect.init(x: 100, y: 100, width: 100, height: 40), titleString: "push", font: UIFont.systemFont(ofSize: 15), textColor: UIColor.red, bgImage: UIImage.init())
        button.addTarget(self, action: #selector(pushAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
    }

    func pushAction() -> Void {
        let vc = LoginViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
