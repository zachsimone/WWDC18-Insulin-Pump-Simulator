import Foundation
import UIKit

class PumpPageViewController: UIViewController,UIScrollViewDelegate {
    
    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: Constants.PageView.width, height: Constants.PageView.height))
    var views: [UIView] = [GraphView(),
                           BolusView(),
                           BasalView(),
                           InfoView()]
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        for index in 0..<Constants.PageView.numberOfPages {
            
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size

            let subView = views[index]
            
            subView.frame = CGRect(x: frame.origin.x, y: 0.0, width: scrollView.frame.width, height: scrollView.frame.height)
            
            scrollView.addSubview(subView)
        }
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(Constants.PageView.numberOfPages), height: scrollView.frame.size.height)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
