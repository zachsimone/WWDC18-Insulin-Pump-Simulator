import Foundation
import UIKit

class BasalView: UIView {
    
    let basalsView = ViewBasalsViewController()
    let editView = ChangeBasalView()
    let tempBasalView = TempBasalView()
    
    let infoHalfView = InfoHalfView(description: Constants.BasalPageDescription.description)

    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setInitialBasal()
        addButtons()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = Constants.Colours.background
        addSubview(screenTitle(title: "Basal"))
        
        let info = infoButton()
        info.addTarget(action, action: #selector(infoButtonTapped), for: .touchUpInside)
        addSubview(info)
    }
    
    func addButtons() {
        
        let editBasalButton = SquareButton(
            frame: Constants.ButtonFrames.editBasalButtonFrame,
            title: "Change basal",
            emoji: "📊",
            buttonAction: editBasalButtonTapped)
        addSubview(editBasalButton)
        
        let setTemporaryBasalButton = SquareButton(
            frame: Constants.ButtonFrames.setTemporaryBasalButtonFrame,
            title: "Temp basal",
            emoji: "📉",
            buttonAction: setTemporaryBasalButtonTapped)
        addSubview(setTemporaryBasalButton)
        
        let viewBasalsButton = RectangularButton(
            frame: Constants.ButtonFrames.viewBasalsButtonFrame,
            title: "View basal schedule",
            buttonAction: viewBasalsButtonTapped)
        addSubview(viewBasalsButton)
    }
    
    func editBasalButtonTapped() {
        editView.clipsToBounds = true
        editView.frame = CGRect(x: 60, y: 40, width: Constants.Buttons.squareButtonWidth, height: Constants.Buttons.squareButtonHeight)
        editView.alpha = 0.0
        let back = backButton(title: "< Back")
        back.addTarget(self, action: #selector(dismissEditBasalView), for: .touchUpInside)
        editView.addSubview(back)
        addSubview(editView)
        
        UIView.animate(withDuration: Constants.Animation.animationDuration, delay: Constants.Animation.normalDelay, options: .curveEaseOut, animations: {
            
            self.editView.alpha = 1.0
            self.editView.frame = Constants.ButtonFrames.halfViewFrame
        })
    }
    
    @objc func dismissEditBasalView() {
        
        UIView.animate(withDuration: Constants.Animation.animationDuration, animations: {
            self.editView.alpha = 0.0
            self.editView.frame = Constants.ButtonFrames.editBasalButtonFrame
        }, completion: { _ in
            self.editView.removeFromSuperview()
        })
    }
    
    func setTemporaryBasalButtonTapped() {
        tempBasalView.clipsToBounds = true
        tempBasalView.frame = Constants.ButtonFrames.setTemporaryBasalButtonFrame
        tempBasalView.alpha = 0.0
        let back = backButton(title: "< Back")
        back.addTarget(self, action: #selector(dismissTempBasalView), for: .touchUpInside)
        tempBasalView.addSubview(back)
        addSubview(tempBasalView)
        
        UIView.animate(withDuration: Constants.Animation.animationDuration, delay: Constants.Animation.normalDelay, options: .curveEaseOut, animations: {
            
            self.tempBasalView.alpha = 1.0
            self.tempBasalView.frame = CGRect(x: self.frame.width/2 - Constants.HalfView.width/2,
                                              y: self.frame.height/2 - CGFloat(Constants.HalfView.height/2),
                                              width: Constants.HalfView.width,
                                              height: Constants.HalfView.height)
        })
    }
    
    @objc func dismissTempBasalView() {
        UIView.animate(withDuration: Constants.Animation.animationDuration, animations: {
            self.tempBasalView.alpha = 0.0
            self.tempBasalView.frame = Constants.ButtonFrames.setTemporaryBasalButtonFrame
        }, completion: { _ in
            self.tempBasalView.removeFromSuperview()
        })
    }
    
    @objc func dismissView() {
        
        UIView.animate(withDuration: Constants.Animation.animationDuration, animations: {
            self.basalsView.view.alpha = 0.0
            self.basalsView.view.frame = CGRect(x: 60, y: 180, width: Constants.Buttons.rectangularButtonWidth, height: Constants.Buttons.rectangularButtonHeight)
        }, completion: { _ in
            self.basalsView.view.removeFromSuperview()
        })
    }
    
    func viewBasalsButtonTapped() {
        basalsView.view.clipsToBounds = true 
        basalsView.view.frame = Constants.ButtonFrames.viewBasalsButtonFrame
        basalsView.view.alpha = 0.0
        let back = backButton(title: "< Back")
        back.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        basalsView.view.addSubview(back)
        addSubview(basalsView.view)
        
        UIView.animate(withDuration: Constants.Animation.animationDuration, delay: Constants.Animation.normalDelay, options: .curveEaseOut, animations: {

            self.basalsView.view.alpha = 1.0
            self.basalsView.view.frame = Constants.ButtonFrames.halfViewFrame
        })
    }
    
    func setInitialBasal() {
        switch currentHourInDay() {
        case 00...05:
            updateCurrentBasal(newBasal: 0.8)
        case 06...10:
            updateCurrentBasal(newBasal: 0.9)
        case 11...16:
            updateCurrentBasal(newBasal: 1.0)
        case 17...20:
            updateCurrentBasal(newBasal: 0.9)
        default:
            updateCurrentBasal(newBasal: 1.1)
        }
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
