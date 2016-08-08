//
//  MoreImagesDownload.swift
//  ThreadDemo
//
//  Created by 也许、 on 16/8/7.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class MoreImagesDownload: UITableViewController {

    let cellId = "cell"
    let array = [ "普通下载图片", "多线程下载图片" , "从内存中取图片" , "从沙盒中取图片" ]
    
    override func viewDidLoad() {
        
        self.title = "多图片下载调优"
        self.view.backgroundColor = UIColor.whiteColor()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        cell?.textLabel?.text = self.array[indexPath.row]
        return cell!
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let title = self.array[indexPath.row]
        
        switch indexPath.row {
        case 0:
            
            let targetController = UIStoryboard(name: "DownloadImg1", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("DownloadImg1") as! DownloadImg1VC
            targetController.myTitle = title
            self.navigationController?.pushViewController(targetController, animated: true)
            
        case 1:
            
            let targetController = UIStoryboard(name: "DownloadImg1", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("DownloadImg2") as! DownloadImg2VC
            targetController.myTitle = title
            self.navigationController?.pushViewController(targetController, animated: true)
            
        case 2:
            
            let targetController = UIStoryboard(name: "DownloadImg1", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("DownloadImg3") as! DownloadImg3VC
            targetController.myTitle = title
            self.navigationController?.pushViewController(targetController, animated: true)
            
        case 3:
            
            let targetController = UIStoryboard(name: "DownloadImg1", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("DownloadImg4") as! DownloadImg4VC
            targetController.myTitle = title
            self.navigationController?.pushViewController(targetController, animated: true)
            
            
        default:
            return
        }
        
    }
    
    
}
