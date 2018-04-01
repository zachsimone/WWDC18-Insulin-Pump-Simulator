import Foundation
import UIKit

class ScreenView: UIView, UIScrollViewDelegate {
    
    let pp = PumpPageViewController()

    var pageControl: UIPageControl = UIPageControl(frame:CGRect(x: Constants.PageView.width/2 - Constants.PageControl.width/2, y: Constants.PageView.height, width: Constants.PageControl.width, height: Constants.PageControl.height))

    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        configurePageControl()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .gray
        
        let statusBar = StatusBar(frame: CGRect(x: 0.0, y: 0.0, width: Constants.ScreenView.width, height: Constants.StatusBar.height))
        addSubview(statusBar)
        
        pp.scrollView.delegate = self
        pp.view.frame = CGRect(x: 0.0, y: Constants.StatusBar.height, width: Constants.PageView.width, height: Constants.PageView.height)
        addSubview(pp.view)
    }
    
    func configurePageControl() {
        pageControl.numberOfPages = Constants.PageView.numberOfPages
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        addSubview(pageControl)
    }
    
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * pp.scrollView.frame.size.width
        pp.scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(pp.scrollView.contentOffset.x / pp.scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
