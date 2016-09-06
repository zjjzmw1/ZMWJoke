//
//  TextViewController.swift
//  ZMWJoke
//
//  Created by xiaoming on 16/8/27.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import UIKit
import Alamofire
import MRPullToRefreshLoadMore

class TextViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,MRPullToRefreshLoadMoreDelegate {

    var arr : NSMutableArray = NSMutableArray()
    var tableView : MRTableView!
    var rowHeightCache : NSCache<AnyObject, AnyObject> = NSCache()
    var currentPage = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "文字"
        // 初始化表格
        self.tableView = MRTableView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - TABBAR_HEIGHT - 15), style: UITableViewStyle.plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.pullToRefresh.pullToRefreshLoadMoreDelegate = self
        self.view .addSubview(self.tableView)
        
        // Class 注册
        tableView.register(TextCell.self, forCellReuseIdentifier: "TextCellID")
        
        // 读取本地数据
        if let resultJson = self.getJsonFromFile() {
            //let readData = try? JSONSerialization.data(withJSONObject: resultJson, options: .prettyPrinted)
            
            let  resultArr = resultJson as! NSArray
            print("获取成功===\(resultArr)");
        } else {
            print("获取失败");
        }
        // 请求数据
        self.requestContent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    /// 下拉刷新请求
    func requestContent() {
        currentPage = 1
        let dict : NSDictionary = ["page":currentPage, "pageSize": 20]
        JokeRequestManager.contentRequestAction(parameters: dict) { (isSuccess, code, result) in
            if isSuccess { // 请求数据成功
                var resultData : NSArray?
                if result != nil {
                    let resultDict : NSDictionary = result as! NSDictionary
                    let dataResultDict : NSDictionary = (resultDict.object(forKey: "result") as? NSDictionary)!
                    resultData = (dataResultDict.object(forKey: "data") as? NSArray)!
                }
                if resultData != nil && (resultData?.count)! > 0 {
                    self.arr = NSMutableArray()
                    for i in 0..<resultData!.count {
                        let dict : NSDictionary = (resultData?.object(at: i) as? NSDictionary)!
                        let textModel = TextModel(content: dict.object(forKey: "content") as! String?, hashId: dict.object(forKey: "hashId") as! String?, updatetime: dict.object(forKey: "updatetime") as! String?, unixtime: dict.object(forKey: "unixtime") as! Int?)
                        self.arr.add(textModel)
                    }
                    
                   // 保存数据 - 应该放在子线程
                    let jsonString : NSString = self.toJSONString(arr: resultData!)!
                    let jsonData :Data? = jsonString.data(using: UInt(String.Encoding.utf8.hashValue))
                    self.saveDataToFile(jsonData: jsonData!)
                    
                }
            }
            // 暂时下拉刷新延迟一秒结束
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                self.tableView.pullToRefresh.setPullState(state: MRPullToRefreshLoadMore.ViewState.Normal)
                self.tableView.reloadData()
            }
        }
    }
    
    /// 上提加载更多的请求
    func requestMoreContent() {
        currentPage += 1
        if currentPage < 1 {
            currentPage = 1
        }
        let dict : NSDictionary = ["page":currentPage, "pageSize": 20]
        JokeRequestManager.contentRequestAction(parameters: dict) { (isSuccess, code, result) in
            if isSuccess { // 请求数据成功
                var resultData : NSArray?
                if result != nil {
                    let resultDict : NSDictionary = result as! NSDictionary
                    let dataResultDict : NSDictionary = (resultDict.object(forKey: "result") as? NSDictionary)!
                    resultData = (dataResultDict.object(forKey: "data") as? NSArray)!
                }
                if resultData != nil && (resultData?.count)! > 0 {
                    for i in 0..<resultData!.count {
                        let dict : NSDictionary = (resultData?.object(at: i) as? NSDictionary)!
                        let textModel = TextModel(content: dict.object(forKey: "content") as! String?, hashId: dict.object(forKey: "hashId") as! String?, updatetime: dict.object(forKey: "updatetime") as! String?, unixtime: dict.object(forKey: "unixtime") as! Int?)
                        self.arr.add(textModel)
                    }
                } else {
                    self.currentPage -= 1
                }
            } else {
                self.currentPage -= 1
            }
            
            self.tableView.pullToRefresh.setLoadMoreState(state: MRPullToRefreshLoadMore.ViewState.Normal)
            self.tableView.reloadData()
        }
    }

    // --------------------------- tableView 上拉、下拉刷新 --------------------------

    func viewShouldRefresh(scrollView:UIScrollView) {
        // if you need a tableview instance
        guard let tableView = scrollView as? MRTableView else {
            return
        }
        
        // refresh table view
        tableView.pullToRefresh.setPullState(state: MRPullToRefreshLoadMore.ViewState.LoadingVertical)
        // 下拉刷新方法
        self.requestContent()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            tableView.pullToRefresh.setPullState(state: MRPullToRefreshLoadMore.ViewState.Normal)
            tableView.reloadData()
        }
    }
    
    func viewShouldLoadMore(scrollView:UIScrollView) {
        // if you need a tableview instance
        guard let tableView = scrollView as? MRTableView else {
            return
        }
        
        // load more
        self.requestMoreContent()
        tableView.pullToRefresh.setLoadMoreState(state: MRPullToRefreshLoadMore.ViewState.LoadingVertical)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            tableView.pullToRefresh.setLoadMoreState(state: MRPullToRefreshLoadMore.ViewState.Normal)
            tableView.reloadData()
        }
        
    }
    // --------------------------- tableView 代理方法 --------------------------
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.arr.object(at: indexPath.row) as! TextModel
        // 从缓存中获取行高。
        if let rowH = rowHeightCache.object(forKey: model.hashId! as AnyObject) as? CGFloat {
            return rowH
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCellID") as! TextCell
        let rowHeight = cell.heightForCell(textModel: model)
        
        // 缓存下来
        let swiftFloat : Float = Float(rowHeight)
        rowHeightCache.setObject(swiftFloat as AnyObject, forKey: model.hashId! as AnyObject)
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 自定义cell
        var cell:TextCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "TextCellID", for: indexPath) as? TextCell
        if cell == nil {
            cell = TextCell(style: .default, reuseIdentifier: "TextCellID")
        }
        // 收藏按钮
        cell?.indexP = indexPath
        cell?.collectionButton.isHidden = true
        /*
        cell.buttonClickBlock = {
            (ind,btn) -> () in
            print(indexPath.row)
            print(btn.currentTitle!)
        }
         */
        // 赋值方法
        let textModel : TextModel = self.arr.object(at: indexPath.row) as! TextModel
        cell?.drawData(textModel: textModel)
        
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

    /// 保存NSData数据到本地文件
    func saveDataToFile(jsonData: Data) {
        //if kPathDocument.count > 0 { // 用Temp目录就可以了，暂时不知道原因
            let file = "joke_content.txt"
            let fileUrl = URL(fileURLWithPath: kPathTemp).appendingPathComponent(file)
            print("fileUrl = \(fileUrl)")
            let data = NSMutableData()
            data.setData(jsonData)
            if data.write(toFile: fileUrl.path, atomically: true) {
                print("保存成功：\(fileUrl.path)")
            } else {
                print("保存失败：\(fileUrl.path)")
            }
        //}
    }
    
    /// 从本地获取Data数据
    func getJsonFromFile() -> Any? {
        let file = "joke_content.txt"
        let fileUrl = URL(fileURLWithPath: kPathTemp).appendingPathComponent(file)
        //let fileUrl = URL(fileURLWithPath: kPathTemp + file)

        print("fileUrl = \(fileUrl)")
        if let readData = NSData.init(contentsOfFile: fileUrl.path) {
            print("获取成功,readData===\(NSString.init(data: readData as Data, encoding: String.Encoding.utf8.rawValue))")
            //return NSString.init(data: readData as Data, encoding: String.Encoding.utf8.rawValue)
            
            let jsonValue = try? JSONSerialization.jsonObject(with: readData as Data, options: .allowFragments)
                // Notice the extra question mark here!

            return jsonValue

        } else {
            print("获取失败：\(fileUrl.path)")
            return nil
        }
        
    }

    
    /// 转换数组到JSONStirng
    func toJSONString(arr: NSArray!) -> NSString? {
        guard let data = try? JSONSerialization.data(withJSONObject: arr, options: .prettyPrinted),
            // Notice the extra question mark here!
            let strJson = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
                //throws MyError.InvalidJSON
            return nil
        }
        
        return strJson
    }
}
