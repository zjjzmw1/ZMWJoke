//
//  TextCell.swift
//  ZMWJoke
//
//  Created by speedx on 16/9/1.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import UIKit
import Foundation

typealias funcBlock = (IndexPath,UIButton) -> ()

class TextCell: UITableViewCell {
    
    var contentLabel:UILabel!
    var collectionButton:UIButton!
    var indexP:IndexPath!
    /// 按钮点击的block回调
    var buttonClickBlock : funcBlock!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Class 初始化---------------------------------------------------------------
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        // 文字
        contentLabel = Tool.initALabel(frame: CGRect.init(x: 10, y: 10, width: SCREEN_WIDTH - 10, height: 100), textString: "测试文字", font: .systemFont(ofSize: 16), textColor: .black)
        self.contentView.addSubview(contentLabel)
        // 收藏按钮
        collectionButton = Tool.initAButton(frame: CGRect.init(x: 10, y: 10, width: SCREEN_WIDTH - 10, height: 100), titleString: "收藏", font: .systemFont(ofSize: 15), textColor: .red, bgImage: UIImage())
        self.contentView.addSubview(collectionButton)
        collectionButton.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
        
    }
    
    func buttonAction(button:UIButton) {
        if (self.buttonClickBlock != nil) {
            self.buttonClickBlock(indexP,collectionButton)
        }
    }
    // 赋值方法
    func drawData(textModel: TextModel) {
        contentLabel.text = textModel.content
        contentLabel.numberOfLines = 0
        contentLabel .sizeToFit()
    }
    
    func heightForCell(textModel: TextModel) -> CGFloat {
        self.layoutIfNeeded()
        contentLabel.text = textModel.content
        contentLabel.numberOfLines = 0
        contentLabel .sizeToFit()
        return contentLabel.bottom() + 10
    }
    
}
