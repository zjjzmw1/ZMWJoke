//
//  TextViewController.swift
//  ZMWJoke
//
//  Created by xiaoming on 16/8/27.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import UIKit
import Alamofire

class TextViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {

    var arr : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "文字"
        
        
        // 表格数据
        arr = ["简单变量操作","控件大全","webView","请求","Polyline"]
        
        // 初始化表格
        let tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view .addSubview(tableView)
        
        // Class 注册
        tableView.register(TextCell.self, forCellReuseIdentifier: "TextCellID")
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 请求文字数据 - 暂时放这
        self.requestContent()

    }
    
    func requestContent() {
        
        let dict : NSDictionary = ["page":1, "pageSize": 20]
        JokeRequestManager.contentRequestAction(parameters: dict) { (isSuccess, code, result) in
            print("isSuccess====\(isSuccess),code===\(code),result===\(result)")
        }
    }
    
    // --------------------------- tableView 代理方法 --------------------------
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 原生的cell
        //        var cell = tableView.dequeueReusableCellWithIdentifier("kMyTableViewCell") as UITableViewCell!
        //        if cell == nil {
        //            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "kMyTableViewCell")
        //        }
        //        cell?.textLabel?.text = arr[indexPath.row]
        //        return cell!;
        
        // 自定义cell
        var cell:TextCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "TextCellID") as! TextCell
        
        cell.indexP = indexPath
        cell.contentLabel.text = arr[indexPath.row] as? String
        cell.contentLabel .sizeToFit()
        if indexPath.row == 0 {
            cell.collectionButton.isHidden = true
        }
        
        cell.buttonClickBlock = {
            (ind,btn) -> () in
            print(indexPath.row)
            print(btn.currentTitle!)
        }
        
        return cell!
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        var detailVC : UIViewController?
        //detailVC = SimpleViewController()
        if detailVC != nil {
            self.navigationController!.pushViewController(detailVC!, animated: true)
        }
    }
    
}
