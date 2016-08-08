//
//  DownloadImg2VC.swift
//  ThreadDemo
//
//  Created by 也许、 on 16/8/8.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class DownloadImg2VC: UITableViewController {
    
    let cellId = "cellId"
    var myTitle:String?
    
    lazy var data:NSArray = {
        
        let path = NSBundle.mainBundle().pathForResource("apps", ofType: "plist")
        return NSArray(contentsOfFile: path!)!
    
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.myTitle
        self.view.backgroundColor = UIColor.whiteColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.data.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)

        let appInfo = self.data[indexPath.row] as! NSDictionary
        cell.textLabel?.text = appInfo["name"] as? String
        
        // 多线程下载，设置延迟1秒是为了模拟网络慢的情景
        let queue = NSOperationQueue()
        queue.addOperationWithBlock { 
            
            let url = NSURL(string: appInfo["icon"] as! String)
            let data = NSData(contentsOfURL: url!)
            let image = UIImage(data: data!)
            NSThread.sleepForTimeInterval(1)
            
            // 主线程设置图片
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                cell.imageView?.image = image!
                cell.layoutSubviews()
            })
            
        }
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
 
}
