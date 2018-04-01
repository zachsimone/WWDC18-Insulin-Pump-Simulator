import Foundation
import UIKit

class BolusView: UIView {
    
    let bolusHistoryView = BolusHistoryViewController()

    let manualBolusView = ManualBolusView()
    let enterBglCarbsBolusView = EnterBglCarbsBolusView()
    
    let infoHalfView = InfoHalfView(description: Constants.BolusPageDescription.description)

    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = Constants.Colours.background
        addSubview(screenTitle(title: "Bolus"))

        let info = infoButton()
        info.addTarget(action, action: #selector(infoButtonTapped), for: .touchUpInside)
        addSubview(info)
        
        setupButtons()
    }
    
    func setupButtons() {
        
        let manualBolusButton = SquareButton(
            frame: Constants.ButtonFrames.manualBolusButtonFrame,
            title: "Manual bolus",
            emoji: "💉",
            buttonAction: manualBolusButtonTapped)
        addSubview(manualBolusButton)
        
        let enterBglButton = SquareButton(
            frame: Constants.ButtonFrames.enterBglCarbsButtonFrame,
            title: "Bolus wizard",
            emoji: "💊",
            buttonAction: enterBglCarbsButtonTapped)
        addSubview(enterBglButton)
        
        let viewBolusHistoryButton = RectangularButton(
            frame: Constants.ButtonFrames.viewBolusHistoryButtonFrame,
            title: "View bolus history",
            buttonAction: viewBolusHistoryButtonTapped)
        addSubview(viewBolusHistoryButton)
    }
    
    func manualBolusButtonTapped() {
        manualBolusView.clipsToBounds = true
        manualBolusView.frame = Constants.ButtonFrames.manualBolusButtonFrame
        manualBolusView.alpha = 0.0
        let back = backButton(title: "< Back")
        back.addTarget(self, action: #selector(dismissManualBolusView), for: .touchUpInside)
        manualBolusView.addSubview(back)
        addSubview(manualBolusView)
    
        UIView.animate(withDuration: Constants.Animation.animationDuration, delay: Constants.Animation.normalDelay, options: .curveEaseOut, animations: {
            
            self.manualBolusView.alpha = 1.0
            self.manualBolusView.frame = CGRect(x: self.frame.width/2 - Constants.HalfView.width/2,
                                                       y: self.frame.height/2 - CGFloat(Constants.HalfView.height/2),
                                                       width: Constants.HalfView.width,
                                                       height: Constants.HalfView.height)
        })
    }
    
    func enterBglCarbsButtonTapped() {

        enterBglCarbsBolusView.clipsToBounds = true
        enterBglCarbsBolusView.frame = Constants.ButtonFrames.enterBglCarbsButtonFrame
        enterBglCarbsBolusView.alpha = 0.0
        let back = backButton(title: "< Back")
        back.addTarget(self, action: #selector(dismissEnterBglView), for: .touchUpInside)
        enterBglCarbsBolusView.addSubview(back)
        addSubview(enterBglCarbsBolusView)
        
        UIView.animate(withDuration: Constants.Animation.animationDuration, delay: Constants.Animation.normalDelay, options: .curveEaseOut, animations: {
            
            self.enterBglCarbsBolusView.alpha = 1.0
            self.enterBglCarbsBolusView.frame = Constants.ButtonFrames.halfViewFrame
        })
    }
    
    @objc func dismissEnterBglView() {
        UIView.animate(withDuration: Constants.Animation.animationDuration, animations: {
            self.enterBglCarbsBolusView.alpha = 0.0
            self.enterBglCarbsBolusView.frame = Constants.ButtonFrames.enterBglCarbsButtonFrame
        }, completion: { _ in
            self.enterBglCarbsBolusView.removeFromSuperview()
        })
    }
    
    @objc func dismissManualBolusView() {
        UIView.animate(withDuration: Constants.Animation.animationDuration, animations: {
            self.manualBolusView.alpha = 0.0
            self.manualBolusView.frame = Constants.ButtonFrames.manualBolusButtonFrame
        }, completion: { _ in
            self.manualBolusView.removeFromSuperview()
        })
    }
    
    @objc func dismissHistoryView() {
        
        UIView.animate(withDuration: Constants.Animation.animationDuration, animations: {
            self.bolusHistoryView.view.alpha = 0.0
            self.bolusHistoryView.view.frame = CGRect(x: 60, y: 180, width: Constants.Buttons.rectangularButtonWidth, height: Constants.Buttons.rectangularButtonHeight)
        }, completion: { _ in
            self.bolusHistoryView.view.removeFromSuperview()
        })
    }
    
    func viewBolusHistoryButtonTapped() {
        bolusHistoryView.view.clipsToBounds = true
        bolusHistoryView.view.frame = Constants.ButtonFrames.viewBolusHistoryButtonFrame
        bolusHistoryView.view.alpha = 0.0
        let back = backButton(title: "< Back")
        back.addTarget(self, action: #selector(dismissHistoryView), for: .touchUpInside)
        bolusHistoryView.view.addSubview(back)
        addSubview(bolusHistoryView.view)
        
        UIView.animate(withDuration: Constants.Animation.animationDuration, delay: Constants.Animation.normalDelay, options: .curveEaseOut, animations: {
            
            self.bolusHistoryView.view.alpha = 1.0
            self.bolusHistoryView.view.frame = Constants.ButtonFrames.halfViewFrame
        })
    }

    @objc func infoButtonTapped() {
        if !subviews.contains(infoHalfView) {
            
            infoHalfView.alpha = 0.0
            infoHalfView.clipsToBounds = true
            addSubview(infoHalfView)
            
            UIView.animate(withDuration: Constants.Animation.animationDuration, delay: Constants.Animation.normalDelay, options: .curveEaseOut, animations: {
                self.infoHalfView.alpha = 1.0
            })
        }
    }
}
