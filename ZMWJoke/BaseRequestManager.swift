//
//  NetworkTool.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit
import Alamofire

let kNetwork_Invalid_Code   =   -3010
let kHttp_Error_Code        =   -3020
let kSocial_Login_Failed    =   -3030

let kResponse_Code_Key      =   "code"
let kResponse_Message_Key   =   "message"
let kResponse_Result_Key    =   "result"

class BaseRequestManager: NSObject {
    
    static let requestBaseManager : BaseRequestManager = BaseRequestManager()
    class func defaultManager() -> BaseRequestManager {
        return requestBaseManager
    }
    
    required override init() {
        super.init()
        
    }

    class func baseRequestAction(urlString: String, method: HTTPMethod, parameters:NSDictionary, completion:@escaping (_ isSuccessed:Bool,_ code:Int?,_ jsonValue:AnyObject?) -> ()) {

        
        do {
            let urlRequest = try URLRequest.init(url: URL.init(string: urlString)!, method: method, headers: nil)
            Alamofire.request(urlRequest).responseJSON(completionHandler: { (response) in
//                print("jsonRequest:\(response.result)")
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                }
                
                completion(response.result.isSuccess, response.response?.statusCode, response.result.value as AnyObject?)

            })
            
        } catch  {
            
        }

        
        
        
//        Alamofire.request(urlString, method: method, parameters: parameters as? [String : Any], encoding: .url, headers: nil).responseJSON { (response) in
//
//            completion(response.result.isSuccess, response.response?.statusCode, response.result.value as AnyObject?)
//        }
 
        // 这种方式是OK的
        /*
         Alamofire.request("http://japi.juhe.cn/joke/content/text.from?page=1&pagesize=20&key=b13defd332c76c3abf2895f7796e2a45", withMethod: .get).responseJSON { (response) in
         print("====\(response)")
         }
         */

    }
    
}
