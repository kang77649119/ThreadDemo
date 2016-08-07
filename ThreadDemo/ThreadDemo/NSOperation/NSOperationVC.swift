//
//  NSOperationVC.swift
//  ThreadDemo
//
//  Created by 也许、 on 16/8/4.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class NSOperationVC: UIViewController {
    
    // 合并图片
    @IBOutlet weak var mergeImg: UIImageView!
    
    // 队列
    var currentQueue:NSOperationQueue?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "NSOperation多线程"
        self.view.backgroundColor = UIColor.whiteColor()
 
    }
    
    /**
        NSBlockOperation + 主线程
     */
    @IBAction func blockOperationMainThread(sender: UIButton) {
        
        let operation = NSBlockOperation {
            print("任务1-------", NSThread.currentThread())
        }
        
        operation.addExecutionBlock { 
            print("任务11------", NSThread.currentThread())
        }
        
        let operation2 = NSBlockOperation {
            print("任务2-------", NSThread.currentThread())
        }
        
        let operation3 = NSBlockOperation {
            print("任务3--------", NSThread.currentThread())
        }
        
        let queue = NSOperationQueue.mainQueue()
        queue.addOperation(operation)
        queue.addOperation(operation2)
        queue.addOperation(operation3)
        
    }
    
    /**
        NSBlockOperation + 其他线程
     */
    @IBAction func blockOperationOtherThread(sender: UIButton) {
        
        let operation = NSBlockOperation {
            print("任务1-------", NSThread.currentThread())
        }
        
        operation.addExecutionBlock { 
            print("任务11------", NSThread.currentThread())
        }
        
        operation.addExecutionBlock {
            print("任务11------", NSThread.currentThread())
        }
        
        let operation2 = NSBlockOperation {
            print("任务2-------", NSThread.currentThread())
        }
        
        let operation3 = NSBlockOperation {
            print("任务3--------", NSThread.currentThread())
        }
        
        let queue = NSOperationQueue()
        queue.addOperation(operation)
        queue.addOperation(operation2)
        queue.addOperation(operation3)
        
    }
    
    /**
        自定义NSOperation
     */
    @IBAction func customNSOperation(sender: UIButton) {
        
        let operation = CustomOperation()
        let queue = NSOperationQueue()
        queue.addOperation(operation)
        
    }
    
    /**
        手动启动任务
        默认在主线程执行,如果放在异步线程中,则会变成异步线程
     */
    @IBAction func commonOperation(sender: UIButton) {
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue) { 
            let operation = NSBlockOperation {
                print("手动启动--任务1", NSThread.currentThread())
            }
            
            operation.addExecutionBlock({ 
                print("手动启动线程---任务2", NSThread.currentThread())
            })
            
            operation.addExecutionBlock({
                print("手动启动线程---任务3", NSThread.currentThread())
            })
            
            operation.addExecutionBlock({
                print("手动启动线程---任务4", NSThread.currentThread())
            })
            
            operation.start()
        }
        
    }

    /**
        最大并发数
     */
    @IBAction func maxConcurrentCount(sender: UIButton) {
        
        let queue = NSOperationQueue()
        // 为0时，任务不执行 为1时，串行队列
//        queue.maxConcurrentOperationCount = 0
        // > 1 并发队列
        queue.maxConcurrentOperationCount = 2
        
        queue.addOperationWithBlock {
            print("任务1----", NSThread.currentThread())
            NSThread.sleepForTimeInterval(1)
        }
        
        queue.addOperationWithBlock {
            print("任务2----", NSThread.currentThread())
            NSThread.sleepForTimeInterval(1)
        }
        
        queue.addOperationWithBlock {
            print("任务3----", NSThread.currentThread())
            NSThread.sleepForTimeInterval(1)
        }
        
        queue.addOperationWithBlock {
            print("任务4----", NSThread.currentThread())
            NSThread.sleepForTimeInterval(1)
        }
        
        queue.addOperationWithBlock {
            print("任务5----", NSThread.currentThread())
            NSThread.sleepForTimeInterval(1)
        }
        
        queue.addOperationWithBlock {
            print("任务6----", NSThread.currentThread())
            NSThread.sleepForTimeInterval(1)
        }
        
        queue.addOperationWithBlock {
            print("任务7----", NSThread.currentThread())
            NSThread.sleepForTimeInterval(1)
        }
        
    }
    
    /**
        任务开启
        只有是串行时才会触发任务挂起
     */
    @IBAction func operationStart(sender: UIButton) {
        
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperationWithBlock {
            
            for i in 0...5000 {
                print("任务1--------", i ,NSThread.currentThread())
            }
            
        }
        
        queue.addOperationWithBlock {
            
            for i in 0...5000 {
                print("任务2--------", i ,NSThread.currentThread())
            }
            
        }
        
        queue.addOperationWithBlock {
            
            for i in 0...5000 {
                print("任务3--------", i ,NSThread.currentThread())
            }
            
        }
        
        self.currentQueue = queue
        
    }
    
    /**
        任务挂起
        只有串行时才会触发任务挂起
     */
    @IBAction func suspended(sender: UIButton) {
        
        guard let queue = self.currentQueue else {
            return
        }
        
        queue.suspended = !self.currentQueue!.suspended
        
    }
    
    /**
        自定义NSOperation 如果不判断队列是否取消，队列中的任务不会被停止
     */
    @IBAction func operationStart2(sender: UIButton) {
    
        let queue = NSOperationQueue()
        let operate = CustomOperation()
        queue.addOperation(operate)
        
        self.currentQueue = queue
    
    }
    
    /**
        取消队列中的任务
     */
    @IBAction func cancelOperate(sender: UIButton) {
        self.currentQueue?.cancelAllOperations()
    }
    
    /**
        普通NSOperation任务开启
     */
    @IBAction func simpleNSOperationStart(sender: UIButton) {
        
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1
        

        let operate = NSBlockOperation { 
            for i in 0...5000 {
                print("任务1-------", i, NSThread.currentThread())
            }
        }
        
        let operate2 = NSBlockOperation {
            for i in 0...5000 {
                print("任务2-------", i, NSThread.currentThread())
            }
        }
        
        let operate3 = NSBlockOperation {
            for i in 0...5000 {
                print("任务3-------", i, NSThread.currentThread())
            }
        }
        
        queue.addOperation(operate)
        queue.addOperation(operate2)
        queue.addOperation(operate3)
        
        self.currentQueue = queue
    
    }
    
    /**
        合并图片
     */
    @IBAction func mergeImgs(sender: UIButton) {
        
        // 并发队列
        let queue = NSOperationQueue()
        
        // 下载图片1任务
        var img1:UIImage?
        let operate = NSBlockOperation { 
            
            let url = NSURL(string: "http://i1.qhimg.com/dr/705_705_/t01328d16e673160411.png")
            let data = NSData(contentsOfURL: url!)
            img1 = UIImage(data: data!)
            
        }
        
        // 下载图片2任务
        var img2:UIImage?
        let operate2 = NSBlockOperation {
            
            let url = NSURL(string: "http://images.takungpao.com/2013/0531/20130531103303406.jpg")
            let data = NSData(contentsOfURL: url!)
            img2 = UIImage(data: data!)
            
        }
        
        // 合并
        let operate3 = NSBlockOperation { 
            
            // 合并图片
            UIGraphicsBeginImageContext(self.mergeImg.bounds.size)
            
            img1?.drawInRect(CGRectMake(0, 0, self.mergeImg!.frame.width * 0.5 , self.mergeImg!.frame.height))
            
            img2?.drawInRect(CGRectMake(self.mergeImg!.frame.width * 0.5, 0, self.mergeImg.frame.width * 0.5, self.mergeImg.frame.height))
            
            let mergeImg = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            // 在主队列中显示图片
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                self.mergeImg.image = mergeImg
            })
            
        }
        
        // 确保合并操作在任务1和任务2之后执行，需要添加依赖
        operate3.addDependency(operate)
        operate3.addDependency(operate2)
        
        queue.addOperation(operate)
        queue.addOperation(operate2)
        queue.addOperation(operate3)
        
    }
    
    /**
        任务依赖
     */
    @IBAction func operateDependency(sender: UIButton) {
    
        let queue = NSOperationQueue()
        let operate = NSBlockOperation {
            for i in 0...50 {
                print("任务1--------", i, NSThread.currentThread())
            }
        }
        
        let operate2 = NSBlockOperation {
            for i in 0...50 {
                print("任务2--------", i, NSThread.currentThread())
            }
        }
        
        let operate3 = NSBlockOperation {
            for i in 0...50 {
                print("任务3--------", i, NSThread.currentThread())
            }
        }
        
        let operate4 = NSBlockOperation {
            for i in 0...50 {
                print("任务4--------", i, NSThread.currentThread())
            }
        }
        
        let operate5 = NSBlockOperation {
            for i in 0...50 {
                print("任务5--------", i, NSThread.currentThread())
                NSThread.sleepForTimeInterval(0.2)
            }
        }
        
        // 任务3 依赖 任务1和任务2，表示任务3一定是在任务1和任务2执行完成后再执行
        operate3.addDependency(operate)
        operate3.addDependency(operate2)
        
        queue.addOperation(operate)
        queue.addOperation(operate2)
        queue.addOperation(operate3)
        queue.addOperation(operate4)
        queue.addOperation(operate5)
    
    }
    
    /**
        任务监听
     */
    @IBAction func operateListening(sender: UIButton) {
        
        let operate = NSBlockOperation {
            for i in 0...500 {
                print("执行任务", i, NSThread.currentThread())
            }
        }
        
        operate.completionBlock = {
            print("执行完成~~~~~~")
        }
        
        NSOperationQueue().addOperation(operate)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
