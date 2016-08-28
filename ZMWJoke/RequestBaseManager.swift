//
//  RequestBaseManager.swift
//  speedxSwift
//
//  Created by speedx on 16/4/25.
//  Copyright © 2016年 speedx. All rights reserved.
//

import Alamofire

let kNetwork_Invalid_Code   =   -3010
let kHttp_Error_Code        =   -3020
let kSocial_Login_Failed    =   -3030

let kResponse_Code_Key      =   "code"
let kResponse_Message_Key   =   "message"
let kResponse_Result_Key    =   "result"


class RequestBaseManager: NSObject {

    static let requestBaseManager : RequestBaseManager = RequestBaseManager()
    class func defaultManager() -> RequestBaseManager {
        return requestBaseManager
    }
    
    required override init() {
        super.init()
        
    }
    
    /*
    class func baseRequestJson(method:Alamofire.Method,urlString:String,parameters:[String:AnyObject]? = nil,completion:(_ isSuccessed:Bool,_ code:Int?,_ jsonValue:AnyObject?) -> ()) {
        Alamofire.request(method, urlString, parameters: parameters,encoding: .URL,headers: nil).responseJSON { response in
            // 返回是否成功的bool , 状态码 int , json 数据结果
            // 如果状态码是200  isSuccess 是失败的话，是因为返回的不是json数据
            completion(isSuccessed:response.result.isSuccess,code:response.response?.statusCode,jsonValue:response.result.value)
        }
        
    }
    */
    

    
    

    
}
