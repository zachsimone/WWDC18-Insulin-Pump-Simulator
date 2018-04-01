import Foundation
import UIKit

class InfoView: UIView {
    
    let boxOne = InfoBox(title: "Current Basal", value: "--U/h", emoji: "📈")
    let boxTwo = InfoBox(title: "Active Insulin", value: "0.0U", emoji: "💉")
    let boxThree = InfoBox(title: "Last Bolus", value: "4.9U @ 8:27am", emoji: "🍔")
    let boxFour = InfoBox(title: "Last BGL", value: "6.1 mmol/L", emoji: "📉")

    let infoHalfView = InfoHalfView(description: Constants.InfoPageDescription.description)

    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupBoxes()
        
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateLabels), userInfo: nil, repeats: true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = Constants.Colours.background
        addSubview(screenTitle(title: "Pump information"))
        
        let info = infoButton()
        info.addTarget(action, action: #selector(infoButtonTapped), for: .touchUpInside)
        addSubview(info)
    }
    
    @objc func updateLabels() {
        boxOne.updateValue(newValue: "\(data.currentBasal)U/h")
        boxTwo.updateValue(newValue: "\(data.activeInsulin) units")
        boxThree.updateValue(newValue: data.bolusHistoryAmounts[data.bolusHistoryAmounts.count-1])
        boxFour.updateValue(newValue: "\(data.lastBgl) mmol/L")
    }
    
    func setupBoxes() {
        boxOne.frame.origin.y = Constants.Padding.largePadding*3
        boxOne.frame.origin.x = Constants.Padding.largePadding
        addSubview(boxOne)
        
        boxTwo.frame.origin.y = Constants.Padding.largePadding*3
        boxTwo.frame.origin.x = boxOne.frame.width + Constants.Padding.largePadding*2
        addSubview(boxTwo)

        boxThree.frame.origin.y = 127
        boxThree.frame.origin.x = Constants.Padding.largePadding
        addSubview(boxThree)

        boxFour.frame.origin.y = 127
        boxFour.frame.origin.x = boxThree.frame.width + Constants.Padding.largePadding*2
        addSubview(boxFour)
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
