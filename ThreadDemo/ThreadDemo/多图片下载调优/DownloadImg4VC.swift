//
//  DownloadImg4VC.swift
//  ThreadDemo
//
//  Created by 也许、 on 16/8/8.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class DownloadImg4VC: UITableViewController {
    
    let cellId = "cellId"
    var myTitle:String?
    
    lazy var queue = {
        return NSOperationQueue()
    }()
    
    lazy var data:NSArray = {
        
        let path = NSBundle.mainBundle().pathForResource("apps", ofType: "plist")
        return NSArray(contentsOfFile: path!)!
        
    }()
    
    // 存放下载过的图片
    var imgs:NSMutableDictionary?
    
    var operates:NSMutableDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.myTitle
        self.view.backgroundColor = UIColor.whiteColor()
        
        imgs = NSMutableDictionary(capacity: self.data.count)
        operates = NSMutableDictionary(capacity: self.data.count)
        
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
        
        // 判断沙盒中是否有图片
        let cacheDirPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask , true).last! as NSString
        
        
        // 判断内存中是否有下载过的图片,如果有从内存中取出，没有则下载图片
        if let img = self.imgs![appInfo["icon"] as! String] as? UIImage {
            print("从内存中取出图片")
            cell.imageView?.image = img
            
        } else {
            
            let iconPath = appInfo["icon"] as! NSString
            
            // 判断沙盒中是否有图片
            let filePath = cacheDirPath.stringByAppendingPathComponent(iconPath.lastPathComponent)
            if(NSFileManager.defaultManager().fileExistsAtPath(filePath)) {
                
                print("从沙盒中取出图片")
                
                // 从沙盒中取出图片
                let data = NSData(contentsOfFile: filePath)
                cell.imageView?.image = UIImage(data: data!)
                
            } else {
            
                // 当滑动频率很快时，避免下载任务重复，先判断下载任务是否已存在
                if self.operates![iconPath] == nil {
                    
                    // 多线程下载，设置延迟1秒是为了模拟网络慢的情景
                    let operate = NSBlockOperation(block: {
                        
                        print("图片下载")
                        NSThread.sleepForTimeInterval(1)
                        
                        let url = NSURL(string: iconPath as String)
                        let data = NSData(contentsOfURL: url!)
                        
                        // 图片下载失败，把当前任务从任务列表中移除，再次滑动表格时会重新下载
                        guard let imgData = data else {
                            self.operates!.removeObjectForKey(appInfo)
                            return
                        }
                        
                        let image = UIImage(data: imgData)
                        
                        // 放到内存中
                        self.imgs![iconPath] = image
                        
                        // 写到沙盒中
                        do {
                            
                            let fileName = NSString(string: iconPath).lastPathComponent
                            let filePath = cacheDirPath.stringByAppendingPathComponent(fileName)
                            try data!.writeToFile( filePath, options: .DataWritingFileProtectionComplete)
                            
                        } catch {
                            print("写入沙盒失败")
                        }
                        
                        // 主线程设置图片
                        NSOperationQueue.mainQueue().addOperationWithBlock({
                            cell.imageView?.image = image!
                            // 立即刷新单元格
                            cell.layoutSubviews()
                        })
                        
                    })
                    
                    queue.addOperation(operate)
                    self.operates![iconPath] = operate
                    
                } else {
                    print("下载任务已存在")
                }
                
            }
            
        }
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
