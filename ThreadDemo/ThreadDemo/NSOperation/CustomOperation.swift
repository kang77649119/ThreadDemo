//
//  CustomOperation.swift
//  ThreadDemo
//
//  Created by 也许、 on 16/8/4.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class CustomOperation: NSOperation {
    
    override func main() {
        
        for i in 0...5000 {
            print("必须重写才能执行任务1-------", i, NSThread.currentThread())
            // 在这里判断会立即停止
//            if self.cancelled {
//                return
//            }
        }
        
        if self.cancelled == true {
            return
        }
        
        for i in 0...5000 {
            print("必须重写才能执行任务2-------", i, NSThread.currentThread())
        }
        
        if self.cancelled == true {
            return
        }
        
        for i in 0...5000 {
            print("必须重写才能执行任务3-------", i, NSThread.currentThread())
        }
        
    }

}
