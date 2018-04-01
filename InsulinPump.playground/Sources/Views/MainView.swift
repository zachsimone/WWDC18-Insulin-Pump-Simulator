import Foundation
import UIKit

open class MainView: UIView {
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: Constants.MainView.width, height: Constants.MainView.height))
        
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = Constants.Colours.background
        
        // Setup frame/border of pump
        let grayBezel = UIView()
        grayBezel.backgroundColor = .gray
        grayBezel.frame = CGRect(
            x: Constants.MainView.width/2 - Constants.GrayFrame.width/2,
            y: Constants.MainView.height/2 - Constants.GrayFrame.height/2,
            width: Constants.GrayFrame.width,
            height: Constants.GrayFrame.height)
        grayBezel.layer.cornerRadius = Constants.GrayFrame.cornerRadius
        addSubview(grayBezel)
        
        let blackBorder = UIView()
        blackBorder.backgroundColor = .black
        blackBorder.frame = CGRect(
            x: Constants.MainView.width/2 - Constants.BlackFrame.width/2,
            y: Constants.MainView.height/2 - Constants.BlackFrame.height/2,
            width: Constants.BlackFrame.width,
            height: Constants.BlackFrame.height)
        blackBorder.layer.cornerRadius = Constants.BlackFrame.cornerRadius
        addSubview(blackBorder)
        
        let screenView = ScreenView(frame: CGRect(
            x: Constants.MainView.width/2 - Constants.ScreenView.width/2,
            y: Constants.MainView.height/2 - Constants.ScreenView.height/2,
            width: Constants.ScreenView.width,
            height: Constants.ScreenView.height))
        screenView.clipsToBounds = true
        screenView.layer.cornerRadius = Constants.ScreenView.cornerRadius
        addSubview(screenView)
    }
}
