//
//  ImageViewController.swift
//  Covid19
//
//  Created by comsoft on 2021/11/12.
//  Copyright © 2021 comsoft. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate  {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var images = [#imageLiteral(resourceName: "1sp.png"),#imageLiteral(resourceName: "2sp.png"),#imageLiteral(resourceName: "3sp.png"),#imageLiteral(resourceName: "4sp.png")]
    var imageViews = [UIImageView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        addContentScrollView()
        setPageControl()
    }
    private func addContentScrollView() {
        for i in 0..<images.count {
            let imageView = UIImageView()
            let xPos = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            imageView.image = images[i]
            scrollView.addSubview(imageView)
            scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
        }
    }
    private func setPageControl() {
        pageControl.numberOfPages = images.count
    }
    private func setPageControlSelectedPage(currentPage:Int) {
        pageControl.currentPage = currentPage
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
}
