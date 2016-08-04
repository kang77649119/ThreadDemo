//
//  NSThreadVC.swift
//  ThreadDemo
//
//  Created by 也许、 on 16/8/4.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class NSThreadVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "NSThread多线程"
        self.view.backgroundColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**s
        使用NSThread开启线程
        并发执行任务
     */
    @IBAction func thread(sender: UIButton) {
        
        let thread01 = NSThread(target: self, selector: #selector(self.run), object: nil)
        thread01.name = "线程1"
        
        let thread02 = NSThread(target: self, selector: #selector(self.run), object: nil)
        thread02.name = "线程2"
        
        let thread03 = NSThread(target: self, selector: #selector(self.run), object: nil)
        thread03.name = "线程3"
        
        thread01.start()
        thread02.start()
        thread03.start()
        
    }
    
    func run() {
        
        for i in 0...100 {
            print(NSThread.currentThread().name!,"~~~~~~~",i)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
