//
//  RunLoopVC.swift
//  ThreadDemo
//
//  Created by 也许、 on 16/8/9.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class RunLoopVC: UITableViewController {

    let cellId = "cellId"
    let data = ["RunLoop模式切换" , "在指定模式下显示图片" , "常驻线程"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "RunLoop应用"
        self.view.backgroundColor = UIColor.whiteColor()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        cell!.textLabel?.text = self.data[indexPath.row]
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
            
            case 0:
                let targetController = UIStoryboard(name: "RunLoop", bundle: nil).instantiateViewControllerWithIdentifier("RunLoop1") as! RunLoopVC1
                self.navigationController?.pushViewController(targetController, animated: true)
            
            case 1:
                let targetController = UIStoryboard(name: "RunLoop", bundle: nil).instantiateViewControllerWithIdentifier("RunLoop2") as! RunLoopVC2
                self.navigationController?.pushViewController(targetController, animated: true)
                
            case 2:
                let targetController = UIStoryboard(name: "RunLoop", bundle: nil).instantiateViewControllerWithIdentifier("RunLoop3") as! RunLoopVC3
                self.navigationController?.pushViewController(targetController, animated: true)

            
            default:
                return
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
