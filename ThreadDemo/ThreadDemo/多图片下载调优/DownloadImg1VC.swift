//
//  DownloadImg1VC.swift
//  ThreadDemo
//
//  Created by 也许、 on 16/8/7.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class DownloadImg1VC: UITableViewController {

    let cellId = "cellId"
    
    var myTitle: String?
    lazy var data:NSMutableArray! =  {
        
        let path = NSBundle.mainBundle().pathForResource("apps", ofType: "plist")
        return NSMutableArray(contentsOfFile: path!)
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.myTitle!
        self.view.backgroundColor = UIColor.whiteColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.data == nil ? 0 : self.data!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        
        let appInfo = self.data[indexPath.row] as! NSDictionary
        
        // 在主线程中下载图片，界面明显卡顿
        let url = NSURL(string: appInfo["icon"] as! String)
        let imgData = NSData(contentsOfURL:  url!)
        NSThread.sleepForTimeInterval(1)
        cell.imageView?.image = UIImage(data: imgData!)
        cell.textLabel?.text = appInfo["name"] as? String

        return cell
    }


}
