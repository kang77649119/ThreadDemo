//
//  RunLoopVC2.swift
//  ThreadDemo
//
//  Created by 也许、 on 16/8/10.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class RunLoopVC2: UIViewController {
    

    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showImage() {
        
        print("设置图片~~~~~~~", NSThread.currentThread())
        self.imgView.image = UIImage(named: "1")

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // 在NSDefaultRunLoopMode模式下处理任务，当滑动textview时不执行显示图片的任务
        self.performSelector(#selector(self.showImage), withObject: nil, afterDelay: 3, inModes: [ NSDefaultRunLoopMode ])
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
