//
//  DownloadImg3VC.swift
//  ThreadDemo
//
//  Created by 也许、 on 16/8/8.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class DownloadImg3VC: UITableViewController {
    
    let cellId = "cellId"
    var myTitle:String?
    
    lazy var data:NSArray = {
        
        let path = NSBundle.mainBundle().pathForResource("apps", ofType: "plist")
        return NSArray(contentsOfFile: path!)!
        
    }()
    
    // 存放下载过的图片
    var imgs:NSMutableDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.myTitle
        self.view.backgroundColor = UIColor.whiteColor()
        
        imgs = NSMutableDictionary(capacity: self.data.count)
        
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
        
        // 判断内存中是否有下载过的图片,如果有从内存中取出，没有则下载图片
        if let img = self.imgs![appInfo["icon"] as! String] as? UIImage {
            print("从内存中取出图片")
            cell.imageView?.image = img
            
        } else {
            
            // 多线程下载，设置延迟1秒是为了模拟网络慢的情景
            let queue = NSOperationQueue()
            queue.addOperationWithBlock {
                
                print("图片下载")
                
                let url = NSURL(string: appInfo["icon"] as! String)
                let data = NSData(contentsOfURL: url!)
                let image = UIImage(data: data!)
                
                // 以字典为key,存到imgs中
                self.imgs![appInfo["icon"] as! String] = image
                
                NSThread.sleepForTimeInterval(1)
                
                // 主线程设置图片
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    cell.imageView?.image = image!
                    cell.layoutSubviews()
                })
                
            }
        
        }
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
