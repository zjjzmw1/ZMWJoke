//
//  UIScrollViewExtension-XW.swift
//  XWRefresh
//
//  Created by Xiong Wei on 15/9/9.
//  Copyright © 2015年 Xiong Wei. All rights reserved.
//  简书：猫爪


import UIKit


private var XWRefreshHeaderKey:Void?
private var XWRefreshFooterKey:Void?

private var XWRefreshReloadDataClosureKey:Void?


typealias xwClosureParamCountType = (Int)->Void

public class xwReloadDataClosureInClass {
    var reloadDataClosure:xwClosureParamCountType = { (Int)->Void in }
}
//用于加强一个引用
//var xwRetainClosureClass = xwReloadDataClosureInClass()


public extension UIScrollView {
    
    
    /** ===========================================================================================
                                        1.2 version 
    ===============================================================================================*/

    
    //MARK: 1.2 version

    /** reloadDataClosure */
    var reloadDataClosureClass:xwReloadDataClosureInClass {
        set{
            
            self.willChangeValue(forKey: "reloadDataClosure")
            //因为闭包不属于class 所以不合适 AnyObject
            objc_setAssociatedObject(self, &XWRefreshReloadDataClosureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            self.didChangeValue(forKey: "reloadDataClosure")
        }
        get{
            if let realClosure = objc_getAssociatedObject(self, &XWRefreshReloadDataClosureKey) {
                return realClosure as! xwReloadDataClosureInClass
            }
            return xwReloadDataClosureInClass()
        }
        
    }
    
	/** 下拉刷新的控件 */
	var headerView:XWRefreshHeader?{

		set{
			if self.headerView == newValue { return }
            
			self.headerView?.removeFromSuperview()
			objc_setAssociatedObject(self,&XWRefreshHeaderKey, newValue , objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)

			if let newHeaderView = newValue {
				self.addSubview(newHeaderView)
			}
		}
		get{
			return objc_getAssociatedObject(self, &XWRefreshHeaderKey) as? XWRefreshHeader
		}
	}



	/** 上拉刷新的控件 */
	var footerView:XWRefreshFooter?{

		set{
			if self.footerView == newValue { return }
			self.footerView?.removeFromSuperview()
			objc_setAssociatedObject(self,&XWRefreshFooterKey, newValue , objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)

			if let newFooterView = newValue {
				self.addSubview(newFooterView)
			}
		}
		get{
			return objc_getAssociatedObject(self, &XWRefreshFooterKey) as? XWRefreshFooter
		}
	}
    
    var totalDataCount:Int{
        
        get{
            var totalCount:Int = 0
            
            if self.isKind(of: UITableView.layerClass){
                let tableView = self as! UITableView
                for section in 0  ..< tableView.numberOfSections  {
                    totalCount += tableView.numberOfRows(inSection: section)
                }
                
            }else if self.isKind(of: UICollectionView.layerClass) {
                let collectionView = self as! UICollectionView
                for section in 0  ..< collectionView.numberOfSections  {
                    totalCount += collectionView.numberOfItems(inSection: section)
                }
            }
            
            return totalCount
            
        }
    }
    
    func executeReloadDataClosure(){
        self.reloadDataClosureClass.reloadDataClosure(self.totalDataCount)
    }

}


extension UITableView {
    
//    open override class func initialize(){
//        if self != UITableView.self { return }
//        
//        struct once{
//            static var onceTaken:dispatch_once_t = 0
//        }
//        
//        dispatch_once(&once.onceTaken) { () -> Void in
//            
//            self.exchangeInstanceMethod1(Selector("reloadData"), method2: Selector("xwReloadData"))
//        }
//        
//    }
    
    func xwReloadData(){
        //正因为交换了方法，所以这里其实是执行的系统自己的 reloadData 方法
        self.xwReloadData()
        
        self.executeReloadDataClosure()
        
    }
}





