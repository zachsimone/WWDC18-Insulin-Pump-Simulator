import Foundation
import UIKit

public class TempBasalView: UIView {
    
    let basalViewModel = BasalViewModel()
    let newPercentageLabel = UILabel()
    let newBasalLabel =  UILabel()
    let lengthOfTimeLabel = UILabel()
    
    var saveButton: RectangularButton?
    
    var currentBasal: Double = data.currentBasal
    var newPercentage: Int = 100
    var lengthOfTime: Int = 0
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: Constants.HalfView.width, height: Constants.HalfView.height))
        
        setupView()
        setupBasalLabel()
        setupButtons()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        currentBasal = basalViewModel.currentBasal
        newPercentageLabel.text = "\(newPercentage)%"
        newPercentageLabel.sizeToFit()
        
        let newBasal = (Double(newPercentage)/100*currentBasal).rounded(toPlaces: 1)
        newBasalLabel.text = "Basal with \(newPercentage)% applied: \(newBasal)U/h"
        newBasalLabel.sizeToFit()
        
        validateTime()
    }
    
    func setupView() {
        backgroundColor = .gray
        layer.cornerRadius = Constants.HalfView.cornerRadius
    }
    
    func setupBasalLabel() {
        newPercentageLabel.text = "\(newPercentage)%"
        newPercentageLabel.font = newPercentageLabel.font.withSize(24.0)
        newPercentageLabel.textColor = .white
        newPercentageLabel.sizeToFit()
        newPercentageLabel.frame.origin.y = 45
        newPercentageLabel.frame.origin.x = frame.width/5 - newPercentageLabel.frame.width/2 
        addSubview(newPercentageLabel)
        
        lengthOfTimeLabel.text = "\(tempHours(length: lengthOfTime))\n\(tempMins(length: lengthOfTime))"
        lengthOfTimeLabel.numberOfLines = 2
        lengthOfTimeLabel.font = lengthOfTimeLabel.font.withSize(24.0)
        lengthOfTimeLabel.textColor = .white
        lengthOfTimeLabel.frame.origin.y = 30
        lengthOfTimeLabel.frame.origin.x = frame.width/5*3 - lengthOfTimeLabel.frame.width/2 + 10
        lengthOfTimeLabel.frame.size.width = 60
        lengthOfTimeLabel.frame.size.height = 60
        addSubview(lengthOfTimeLabel)
        
        newBasalLabel.text = "Basal with \(newPercentage)% applied: \(currentBasal)U/h"
        newBasalLabel.textColor = .white
        newBasalLabel.sizeToFit()
        newBasalLabel.frame.origin.y = 100
        newBasalLabel.frame.origin.x = frame.width/2 - newBasalLabel.frame.width/2
        addSubview(newBasalLabel)
    }
    
    func setupButtons() {
        let upButton = UpButton(buttonAction: upButtonTapped)
        upButton.frame.origin.y = 20
        upButton.frame.origin.x = frame.width/5*2 - upButton.frame.width/2 + 10
        addSubview(upButton)
        
        let downButton = DownButton(buttonAction: downButtonTapped)
        downButton.frame.origin.y = 55
        downButton.frame.origin.x = frame.width/5*2 - downButton.frame.width/2 + 10
        addSubview(downButton)
        
        let increaseTime = UpButton(buttonAction: increaseTimeButtonTapped)
        increaseTime.frame.origin.y = 20
        increaseTime.frame.origin.x = frame.width/5*4 - increaseTime.frame.width/2
        addSubview(increaseTime)
        
        let decreaseTime = DownButton(buttonAction: decreaseTimeButtonTapped)
        decreaseTime.frame.origin.y = 55
        decreaseTime.frame.origin.x = frame.width/5*4 - decreaseTime.frame.width/2
        addSubview(decreaseTime)
        
        saveButton = RectangularButton(
            frame: Constants.ButtonFrames.giveBolusButtonFrame,
            title: "Confirm temp basal",
            buttonAction: saveBasal)
        guard saveButton != nil else { return }
        saveButton!.backgroundColor = Constants.Colours.background
        addSubview(saveButton!)
    }
    
    func upButtonTapped() {
        guard newPercentage <= 200 else { return }
        newPercentage = newPercentage + 1
        let newBasal = (Double(newPercentage)/100*currentBasal).rounded(toPlaces: 1)
        newBasalLabel.text = "Basal with \(newPercentage)% applied: \(newBasal)U/h"
        newBasalLabel.sizeToFit()
        newPercentageLabel.text = "\(newPercentage)%"
        newPercentageLabel.sizeToFit()
    }
    
    func downButtonTapped() {
        guard newPercentage > 0 else { return }
        newPercentage = newPercentage - 1
        let newBasal = (Double(newPercentage)/100*currentBasal).rounded(toPlaces: 1)
        newBasalLabel.text = "Basal with \(newPercentage)% applied: \(newBasal)U/h"
        newBasalLabel.sizeToFit()
        newPercentageLabel.text = "\(newPercentage)%"
        newPercentageLabel.sizeToFit()
    }
    
    @objc func saveBasal() {
        
        updateCurrentBasal(newBasal: (Double(newPercentage)/100*currentBasal).rounded(toPlaces: 1))
        
        UIView.animate(withDuration: Constants.Animation.animationDuration, animations: {
            self.alpha = 0.0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
    func increaseTimeButtonTapped() {
        lengthOfTime = lengthOfTime + 30
        lengthOfTimeLabel.text = "\(tempHours(length: lengthOfTime))\n\(tempMins(length: lengthOfTime))"
        
        validateTime()
    }
    
    func decreaseTimeButtonTapped() {
        guard lengthOfTime >= 30 else { return }
        lengthOfTime = lengthOfTime - 30
        lengthOfTimeLabel.text = "\(tempHours(length: lengthOfTime))\n\(tempMins(length: lengthOfTime))"
        
        validateTime()
    }
    
    func tempHours(length: Int) -> String {
        guard length != 0 else { return "--h" }
        return "\(length / 60)h"
    }
    
    func tempMins(length: Int) -> String {
        guard length != 0 else { return "--m" }
        return "\(length % 60)m"
    }
    
    func validateTime() {
        
        guard saveButton != nil else { return }
        if lengthOfTime > 0 {
            saveButton!.alpha = 1.0
            saveButton!.isUserInteractionEnabled = true
        } else {
            saveButton!.alpha = 0.5
            saveButton!.isUserInteractionEnabled = false
        }
    }
}
