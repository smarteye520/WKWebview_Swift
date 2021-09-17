//
//  ViewController.swift
//  Drona Institute
//
//  Created by smarteye on 4/30/19.
//  Copyright © 2019 smarteye. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var pageControl : UIPageControl!
    var images = [UIImage]()
    var colors:[UIColor] = [UIColor.blue, UIColor.green, UIColor.yellow]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView = UIScrollView(frame: self.view.bounds)
        self.scrollView.delegate = self
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.backgroundColor = UIColor.clear
        self.scrollView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        self.view.addSubview(self.scrollView)
        
//        images = [UIImage(named: ""), UIImage(named: ""), UIImage(named: "")] as! [UIImage]
//        setupImages(images)
        setupImages()
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * 3, height: self.scrollView.frame.size.height)
        
        self.pageControl = UIPageControl(frame: CGRect(x:80, y:480, width:self.view.frame.size.width - 160, height:50))
        configurePageControl()
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
        
        let skipBtn:UIButton = UIButton(frame: CGRect(x: 100, y: 530, width: self.view.frame.size.width - 200, height: 50))
        skipBtn.backgroundColor = UIColor.clear
        skipBtn.setTitle("Skip", for: .normal)
        skipBtn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        skipBtn.tag = 1
        self.view.addSubview(skipBtn)
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = colors.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.darkGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.view.addSubview(pageControl)
    }
    
//    func setupImages(_ images: [UIImage]){
   func setupImages(){
        for i in 0..<colors.count {
//            let subView = UIImageView()
//            subView.image = images[i]
            let xPosition = self.scrollView.frame.size.width * CGFloat(i)
            let subView = UIView(frame: CGRect(x: xPosition, y: 0, width: self.scrollView.frame.size.width, height: scrollView.frame.size.height))
            subView.backgroundColor = colors[i]
//            imageView.contentMode = .scaleAspectFit
            self.scrollView.addSubview(subView)
        }
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {        
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    @objc func buttonClicked(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 1 {
            let mainVC = storyboard?.instantiateViewController(withIdentifier: String(describing: MainViewController.self)) as! MainViewController
            navigationController?.pushViewController(mainVC, animated: false)
        }
    }

}

