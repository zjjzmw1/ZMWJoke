//
//  NetworkTool.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit
import Alamofire

class NetworkTool: NSObject {
    /**
     *  请求 JSON
     *
     *  @param method        HTTP 请求方法
     *  @param URLString     URL字符串
     *  @param parameters    参数字典
     *  @param completion    完成回调，返回NetworkResponse
     */
    /*
    class func requestJSON(method: Alamofire.Method, URLString: String, parameters: [String: AnyObject]? = nil, completion:@escaping (_ response: NetworkResponse?) -> ()) {
        Alamofire.request(method, URLString, parameters: parameters, encoding: .URL, headers: nil).responseJSON { (JSON) in
            switch JSON.result {
            case .Success:
                if let value = JSON.result.value {
                    let nResponse = NetworkResponse(dict: value as! [String : AnyObject])
                    completion(response: nResponse)
                }
            case .Failure(let error):
                debugPrint(error)
            }
        }
    }
 */
    
    
    class func baseRequestAction(method: HTTPMethod, parameters:NSDictionary, completion:@escaping (_ isSuccessed:Bool,_ code:Int?,_ jsonValue:AnyObject?) -> ()) {

        Alamofire.request("https://httpbin.org/post", withMethod: .post, parameters: parameters as? [String : Any], encoding: ParameterEncoding.json, headers: nil).responseJSON { (response) in
            
            completion(response.result.isSuccess, response.response?.statusCode, response.result.value as AnyObject?)
        }
 
    }
    
}
