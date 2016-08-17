//
//  RunLoopVC1.swift
//  ThreadDemo
//
//  Created by 也许、 on 16/8/9.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class RunLoopVC1: UIViewController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    let screenW = UIScreen.mainScreen().bounds.width
    let screenH = UIScreen.mainScreen().bounds.height
    
    let pics = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg"]

    var myTitle:String?
    
    var adScrollView:UIScrollView?
    var adPageControll:UIPageControl?
    
    var currentPage = 0
    
    var timer:NSTimer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化UI
        initUI()
        
    }
    
    /**
        初始化UI
     */
    func initUI() {
        
        self.title = self.myTitle
        self.view.backgroundColor = UIColor.whiteColor()
        
        // 禁止scrollView内边距偏移
        self.automaticallyAdjustsScrollViewInsets = false
        
        // 初始化广告轮播
        initAdScrollView()
        
        // 初始化表格
        initTableView()
        
    }
    
    /**
        初始化广告轮播
     */
    func initAdScrollView() {
    
        let scrollView = UIScrollView(frame: CGRectMake(0, 64, screenW, 200))
        scrollView.backgroundColor = UIColor.blueColor()
        scrollView.contentSize = CGSizeMake(screenW * CGFloat(self.pics.count), 0)
        scrollView.pagingEnabled = true
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        let pageControlX = CGRectGetMaxX(scrollView.frame) - 80
        let pageControlY = CGRectGetMaxY(scrollView.frame) - 20
        let pageControlW:CGFloat = 50
        let pageControlH:CGFloat = 10
        
        let pageControl = UIPageControl(frame: CGRectMake( pageControlX, pageControlY, pageControlW, pageControlH))
        pageControl.numberOfPages = self.pics.count
        pageControl.currentPageIndicatorTintColor = UIColor.yellowColor()
        
        self.view.addSubview(scrollView)
        self.view.insertSubview(pageControl, aboveSubview: scrollView)
        
        self.adScrollView = scrollView
        self.adPageControll = pageControl
        
        let imageW = scrollView.frame.size.width
        let imageH = scrollView.frame.size.height
        
        for i in 0..<self.pics.count {
            
            let imageX = scrollView.bounds.width * CGFloat(i)
            let imageView = UIImageView(frame: CGRectMake(imageX, 0, imageW, imageH))
            let image = UIImage(named: String(format: "%d.jpg", i+1))
            imageView.image = image
            scrollView.addSubview(imageView)
            
        }
        
        // 开启定时器
        startTimer()
        
    }
    
    // 开启定时器
    func startTimer() {
        
        //        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(self.adScroll), userInfo: nil, repeats: true)
        
        // NSRunLoopCommonModes 两种模式都包含，滑动不会冲突
        self.timer = NSTimer(timeInterval: 2, target: self, selector: #selector(self.adScroll), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
        
        print(NSRunLoop.currentRunLoop())
        
    }
    
    // 关闭定时器
    func stopTimer() {
        self.timer?.invalidate()
    }
    
    
    /**
        初始化表格
     */
    func initTableView() {
        
        let table = UITableView(frame: CGRectMake(0, 264, screenW, screenH))
        // 区分广告轮播和表格(滑动时需要区分)
        table.tag = 1001
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cellId")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cellId")
        }
        cell?.textLabel?.text = String(format: "%d----------测试数据", indexPath.row)
        return cell!
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if scrollView.tag != 1001 {
            self.stopTimer()
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.tag != 1001 {
            self.startTimer()
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // 表格的标识为1001，当非1001的控件滑动时，执行下面的方法
        if scrollView.tag != 1001 {
            let scrollX = scrollView.contentOffset.x / screenW
            let index = Int( scrollX )
            
            if index == Int(scrollX + 0.5) {
                self.adPageControll?.currentPage = index
                self.currentPage = index
            }
        }
        
    }
    
    /**
        广告轮播
     */
    func adScroll() {
        
        if self.currentPage == (self.pics.count-1) {
            self.currentPage = 0
            self.adScrollView?.contentOffset.x = 0
        } else {
            self.currentPage += 1
            self.adPageControll?.currentPage = self.currentPage
            self.adScrollView?.contentOffset.x = screenW * CGFloat(self.currentPage)
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
