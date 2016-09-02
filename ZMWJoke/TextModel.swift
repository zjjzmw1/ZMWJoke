//
//  TextModel.swift
//  ZMWJoke
//
//  Created by speedx on 16/9/2.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import UIKit

class TextModel: NSObject {
    var content : String?
    var hashId : String?
    var updatetime : String?
    var unixtime : Int?
    
    init(content: String?, hashId : String?, updatetime: String?, unixtime: Int?) {
        if let newContent = content {
            self.content = newContent
        }
        if let newHashId = hashId {
            self.hashId = newHashId
        }
        if updatetime != nil {
            self.updatetime = updatetime
        }
        if unixtime != nil {
            self.unixtime = unixtime
        }
    }
}
