//
//  TextViewController.swift
//  ZMWJoke
//
//  Created by xiaoming on 16/8/27.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import UIKit
import Alamofire

class TextViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "文字"
        // 请求文字数据
        self.requestContent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func requestContent() {
        
        let dict : NSDictionary = ["page":1, "pageSize": 20]
        JokeRequestManager.contentRequestAction(parameters: dict) { (isSuccess, code, result) in
            print("isSuccess====\(isSuccess),code===\(code),result===\(result)")
        }
    }
}
