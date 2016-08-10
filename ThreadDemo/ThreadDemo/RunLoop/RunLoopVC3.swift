//
//  RunLoopVC3.swift
//  ThreadDemo
//
//  Created by 也许、 on 16/8/10.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class RunLoopVC3: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var secondImgView: UIImageView!
    
    var thread:KThread?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // 在子线程显示图片
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(self.createThread), userInfo: nil, repeats: false)
        
    }
    
    /**
        启动线程
     */
    func createThread() {
        
        if self.thread != nil {
            
            print("线程已存在")
            self.performSelector(#selector(self.showImage), onThread: self.thread!, withObject: nil, waitUntilDone: true)
            
        } else {
            
            print("创建线程")
            
            self.thread = KThread(target: self, selector: #selector(self.createRunLoop), object: nil)
            self.thread!.start()
            
        }
        
    }
   
    /**
        显示图片
     */
    func showImage() {
        
        print("显示图片的线程信息-----", NSThread.currentThread())
        self.imgView.image = UIImage(named: "1")
        
        print("线程执行完成")
    }
    
    func createRunLoop() {
        
        print("显示图片的线程信息-----", NSThread.currentThread())
        self.imgView.image = UIImage(named: "1")
        
        // 创建当前线程下的runloop
        let runloop = NSRunLoop.currentRunLoop()
        // 给runloop中的mode添加信息，确保runloop不会消失
        runloop.addPort(NSPort(), forMode: NSRunLoopCommonModes)
        // 非主线程的runloop，需要手动启动
        runloop.run()
        
        print("线程执行完成")
        
    }
    
    /**
        利用常驻线程，显示第二张图片
     */
    @IBAction func executeOtherOperate(sender: UIButton) {
        self.performSelector(#selector(self.showSecondImage), onThread: self.thread!, withObject: nil, waitUntilDone: true)
    }
    
    /**
        利用已经创建的线程，显示第二张图片
     */
    func showSecondImage() {
    
        print("显示第二张图片的线程信息--------", NSThread.currentThread())
        self.secondImgView.image = UIImage(named: "2")
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
