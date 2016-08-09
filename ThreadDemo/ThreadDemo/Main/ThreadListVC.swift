//
//  ThreadListVC.swift
//  ThreadDemo
//
//  Created by 也许、 on 16/8/4.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class ThreadListVC: UITableViewController {

    let threadList = ["GCD","NSThread","NSOperation","MoreImagesDownload","RunLoop"]
    let cellId = "threadCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化基本UI信息
        settingBasicUI()
        
    }
    
    func settingBasicUI() {
        
        self.title = "多线程类型列表"
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellId)
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.threadList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        cell.textLabel?.text = self.threadList[indexPath.row]
        cell.accessoryType = .DisclosureIndicator
        return cell
        
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let targetName = self.threadList[indexPath.row]
        
        let storyboard = UIStoryboard(name: targetName, bundle: nil)
        let targetController = storyboard.instantiateViewControllerWithIdentifier(targetName)
        self.navigationController?.pushViewController(targetController, animated: true)
      
    }

}
