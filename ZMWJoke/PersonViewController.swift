//
//  PersonViewController.swift
//  ZMWJoke
//
//  Created by xiaoming on 16/8/28.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import UIKit
import Alamofire

class PersonViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "个人中心"
        
        let button = Tool.initAButton(frame: CGRect.init(x: 100, y: 100, width: 100, height: 40), titleString: "push", font: UIFont.systemFont(ofSize: 15), textColor: UIColor.red, bgImage: nil)
        button.addTarget(self, action: #selector(pushAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
    }

    func pushAction() -> Void {
        /*
        let vc = LoginViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        */
        let parameters = [ "foo": "bar","baz": ["a", 1],"qux": ["x": 1,"y": 2,"z": 3]] as [String : Any]
        
//        Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters, encoding: ParameterEncoding.json, headers: nil).responseJSON { (response) in
//            print("jsonRequest:\(response.result)")
//            
//            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
//            }
//        }
//        Alamofire.request(URL.init(string: ""), method: HTTPMethod.post, parameters: parameters, encoding: ParameterEncoding.json, headers: nil).responseJSON(queue: DispatchQueue.main, options: JSONSerialization.ReadingOptions) { (response) in
//            print("jsonRequest:\(response.result)")
//            
//            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
//            }
//
//        }
        
        
//        Alamofire.request(URL.init(string: ""), method: .get, parameters: parameters, encoding: .JSON, headers: nil).responseJSON(queue: DispatchQueue.main, options: JSONSerialization.ReadingOptions) { (response) in
//            print("jsonRequest:\(response.result)")
//            
//                        if let JSON = response.result.value {
//                           print("JSON: \(JSON)")
//                       }
//        }
        
        
        do {
            let urlRequest = try! URLRequest.init(url: "https://httpbin.org/post" as URLConvertible, method: HTTPMethod.post, headers: nil)
            Alamofire.request(urlRequest).responseJSON(completionHandler: { (response) in
                print("jsonRequest:\(response.result)")
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
            })
        }
    }
    
}



































