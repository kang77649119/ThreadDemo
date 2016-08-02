//
//  ViewController.swift
//  ThreadDemo
//
//  Created by 也许、 on 16/8/2.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /**
        GCD同步+并发队列
        在当前线程执行，不会开启新线程(当前线程为主线程就在主线程中执行，如果是子线程就在子线程中执行)
     */
    @IBAction func gcdSyncConcurrent(sender: UIButton) {
        
        // 自定义并发队列
        let queue = dispatch_queue_create("com.k.gcdSyncConcurrent", DISPATCH_QUEUE_CONCURRENT)
        
        // 全局并发队列
//        let globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_sync(queue) {
            
            for _ in 0...10 {
                print("1~~~~~~",NSThread.currentThread())
            }
            
            
        }
        
        dispatch_sync(queue) {
            
            for _ in 0...10 {
                print("2~~~~~~",NSThread.currentThread())
            }
            
        }
        
        dispatch_sync(queue) {
            
            for _ in 0...10 {
                print("3~~~~~~",NSThread.currentThread())
            }
            
        }
        
        // 放在子线程中执行，也不会开启新的线程
//        dispatch_async(queue) {
        
//            dispatch_sync(queue) {
//                
//                for _ in 0...10 {
//                    print("1~~~~~~",NSThread.currentThread())
//                }
//                
//            }
//            
//            dispatch_sync(queue) {
//                
//                for _ in 0...10 {
//                    print("2~~~~~~",NSThread.currentThread())
//                }
//                
//            }
//            
//            dispatch_sync(queue) {
//                
//                for _ in 0...10 {
//                    print("3~~~~~~",NSThread.currentThread())
//                }
//                
//            }
        
//        }
        
    }
    
    /**
        GCD同步+串行队列
     */
    @IBAction func gcdSyncSerial(sender: UIButton) {
        
        // 串行队列
        let queue = dispatch_queue_create("com.k.gcdSyncSerial", DISPATCH_QUEUE_SERIAL)
        
        dispatch_sync(queue) {
            
            for _ in 0...10 {
                print("1~~~~~~",NSThread.currentThread())
            }
            
        }
        
        dispatch_sync(queue) {
            
            for _ in 0...10 {
                print("2~~~~~~",NSThread.currentThread())
            }
            
        }
        
        dispatch_sync(queue) {
            
            for _ in 0...10 {
                print("3~~~~~~",NSThread.currentThread())
            }
            
        }
      
    }
    
    /**
        GCD同步+主队列
        如果在主线程中执行该组合，则会引起线程阻塞，
        因为主队列的任务会立即执行，而gcdSyncMainQueue任务也是在主线程中还未执行完成，主队列的任务会等待主线程中的任务执行完毕后再执行
     */
    @IBAction func gcdSyncMainQueue(sender: UIButton) {
        
        print("主队列开始")
        
        // 队列
        let queue = dispatch_get_main_queue()
        
        dispatch_sync(queue) { 
            
            for _ in 0...10 {
                print("1~~~~~~",NSThread.currentThread())
            }
            
        }
        
        // 如果把任务放在其他线程中，则不会引起线程阻塞
//        dispatch_async(queue) { 
//            dispatch_sync(queue) {
//                
//                for _ in 0...10 {
//                    print("1~~~~~~",NSThread.currentThread())
//                }
//                
//            }
//        }
        
        print("主队列结束")
        
    }
    
    /**
        GCD异步+并发
     */
    @IBAction func gcdAsyncConcurrent(sender: UIButton) {
        
        let queue = dispatch_queue_create("com.k.gcdAsyncConcurrent", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_async(queue) { 
            
            for _ in 0...10 {
                print("1~~~~~~",NSThread.currentThread())
            }
            
        }
        
        dispatch_async(queue) {
            
            for _ in 0...10 {
                print("2~~~~~~",NSThread.currentThread())
            }
            
        }
        
        dispatch_async(queue) {
            
            for _ in 0...10 {
                print("3~~~~~~",NSThread.currentThread())
            }
            
        }
        
    }
    
    /**
        GCD异步+串行
     */
    @IBAction func gcdAsyncSerial(sender: UIButton) {
        
        let queue = dispatch_queue_create("com.k.gcdAsyncSerial", DISPATCH_QUEUE_SERIAL)
        
        dispatch_async(queue) { 
            for _ in 0...10 {
                print("1~~~~~~",NSThread.currentThread())
            }
        }
        
        dispatch_async(queue) {
            for _ in 0...10 {
                print("2~~~~~~",NSThread.currentThread())
            }
        }
        
        dispatch_async(queue) {
            for _ in 0...10 {
                print("3~~~~~~",NSThread.currentThread())
            }
        }
        
    }
    
    /**
        GCD异步+主队列
     */
    @IBAction func gcdAsyncMainQueue(sender: UIButton) {
        
        let queue = dispatch_get_main_queue()
        
        dispatch_async(queue) { 
            for _ in 0...10 {
                print("1~~~~~~",NSThread.currentThread())
            }
        }
        
        dispatch_async(queue) {
            for _ in 0...10 {
                print("2~~~~~~",NSThread.currentThread())
            }
        }
        
        dispatch_async(queue) {
            for _ in 0...10 {
                print("3~~~~~~",NSThread.currentThread())
            }
        }
        
        
    }
    
    /**
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
    
        for i in 0...10 {
            print(NSThread.currentThread().name!,"~~~~~~~",i)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

