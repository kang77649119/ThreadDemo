//
//  ViewController.swift
//  ThreadDemo
//
//  Created by 也许、 on 16/8/2.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var img1:UIImage?
    var img2:UIImage?
    
    @IBOutlet weak var mergerImgView: UIImageView!

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
    
    /**
        栅栏队列
        这种队列会强制阻断其前面和后面的其他队列
        当栅栏队列完成后，后面的队列才会继续执行
     */
    @IBAction func gcdBarrierAsync(sender: UIButton) {
    
        let queue = dispatch_queue_create("com.k.gcdBarrierAsyncQueue", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_async(queue) { 
            
            for i in 0...10 {
                
                print("第一个队列~~~~~~~   ", NSThread.currentThread(),"~~~~~~~~ ",i)
            
            }
            
        }
        
        dispatch_async(queue) {
            
            for i in 0...10 {
                
                print("第二个队列~~~~~~   ", NSThread.currentThread(),"~~~~~~~~ ",i)
                
            }
            
        }
        
        
        dispatch_barrier_async(queue) { 
            
            for _ in 0...10 {
                
                print("barrier队列~~~~~~   ", NSThread.currentThread(),"~~~~~~~~AAAAAAAAA ")
                
            }
            
        }
        
        
        
        dispatch_async(queue) {
            
            for i in 0...10 {
                
                print("第三个队列~~~~~~~   ", NSThread.currentThread(),"~~~~~~~~ ",i)
                
            }
            
        }
        
        dispatch_async(queue) {
            
            for i in 0...10 {
                
                print("第四个队列~~~~~~   ", NSThread.currentThread(),"~~~~~~~~ ",i)
                
            }
            
        }
    
    }
    
    /**
        self.perform 延迟执行
     */
    @IBAction func delayQueue1(sender: UIButton) {
        
        print("队列开始")
        
        self.performSelector(#selector(self.delayTask), withObject: nil, afterDelay: 2)
        
        print("队列结束")
        
        
    }
    
    func delayTask() {
        
        print(NSThread.currentThread(),"执行延迟任务")
        
    }
    
    /**
        NSTimer 延迟执行
     */
    @IBAction func delayQueue2(sender: UIButton) {
        
        print("队列开始")
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(self.delayTask), userInfo: nil, repeats: false)
        
        print("队列结束")
        
    }
    
    /**
        dispatch_after
     */
    @IBAction func gcdDelayQueue3(sender: UIButton) {
        
        print("队列开始")
        
        let queue = dispatch_queue_create("com.k.gcdDelayQueue3", DISPATCH_QUEUE_SERIAL)
        let delay = 2 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, queue) {
            self.delayTask()
        }
        
        print("队列结束")
        
    }
    
    /**
        只执行一次
     */
    private var globalToken: dispatch_once_t = 0
    
    @IBAction func gcdDispatchOnce(sender: UIButton) {
        
        dispatch_once(&globalToken) {
            print("只执行一次")
        }
        
    }
    
    /**
        快速迭代
        可以指定队列
     */
    @IBAction func gcdIteration(sender: UIButton) {
        
        let queue = dispatch_queue_create("com.k.gcdIteration", DISPATCH_QUEUE_CONCURRENT)
        
//        let queue2 = dispatch_queue_create("com.k.gcdIteration", DISPATCH_QUEUE_SERIAL)
        
        dispatch_apply(10, queue) { (index) in
            
            print(NSThread.currentThread(),index)
            
        }
        
    }
    
    /**
        队列组
     */
    @IBAction func gcdDispatchGroup(sender: UIButton) {
        
        let group = dispatch_group_create()
        let queue = dispatch_queue_create("com.k.gcdDispatchGroup", DISPATCH_QUEUE_CONCURRENT)
        
        // 下载图片1
        dispatch_group_async(group, queue) {
            
            print(NSThread.currentThread(),"下载图片1")
            
            // 下载图片1
            let url = NSURL(string: "http://photo.l99.com/bigger/9f2/1427726080118_72f3dd.jpg")
            
            let data = NSData(contentsOfURL: url!)
            self.img1 = UIImage(data: data!)
            
        }
        
        // 下载图片2 335 200
        dispatch_group_async(group, queue) {
            
            print(NSThread.currentThread(),"下载图片2")
            
            // 下载图片2
            let url = NSURL(string: "http://img2.3lian.com/2014/f4/168/d/35.jpg")
            
            let data = NSData(contentsOfURL: url!)
            self.img2 = UIImage(data: data!)
            
        }
        
        dispatch_group_notify(group, queue) {
            
            print(NSThread.currentThread(),"队列组")
            
            UIGraphicsBeginImageContext(self.mergerImgView.frame.size)
            
            self.img1?.drawInRect(CGRectMake(0, 0, 335 * 0.5, 200))
            self.img2?.drawInRect(CGRectMake(335 * 0.5, 0, 335 * 0.5, 200))
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            dispatch_async(dispatch_get_main_queue(), {
                
                print(NSThread.currentThread(),"显示图片")
                
                self.mergerImgView.image = image
            })
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

