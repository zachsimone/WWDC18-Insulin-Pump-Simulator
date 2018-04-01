import Foundation
import UIKit

class StatusBar: UIView {
    
    let viewModel = StatusBarViewModel()
    
    var timeTimer = Timer()
    var insulinTimer = Timer()
    var batteryTimer = Timer()
    var insulinRemainingRefresh = Timer()
    
    let insulinLeft = UILabel()
    let batteryLabel = UILabel()
    let timeLabel = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupTimers()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .gray
        
        insulinLeft.font = insulinLeft.font.withSize(14.0)
        insulinLeft.text = "\(viewModel.insulinLeft)U"
        insulinLeft.sizeToFit()
        insulinLeft.frame.origin.y = self.frame.height/2 - insulinLeft.frame.height/2
        insulinLeft.frame.origin.x = 4
        insulinLeft.textColor = .white
        addSubview(insulinLeft)
        
        batteryLabel.font = batteryLabel.font.withSize(14.0)
        batteryLabel.text = "\(viewModel.batteryPercentage)%"
        batteryLabel.sizeToFit()
        batteryLabel.frame.origin.y = self.frame.height/2 - batteryLabel.frame.height/2
        batteryLabel.frame.origin.x = self.frame.width - batteryLabel.frame.width - 4
        batteryLabel.textColor = .white
        addSubview(batteryLabel)
        
        timeLabel.font = timeLabel.font.withSize(14.0)
        timeLabel.text = viewModel.time
        timeLabel.sizeToFit()
        timeLabel.frame.origin.y = self.frame.height/2 - timeLabel.frame.height/2
        timeLabel.frame.origin.x = self.frame.width/2 - timeLabel.frame.width/2
        timeLabel.textColor = .white
        addSubview(timeLabel)
    }
    
    func setupTimers() {
        timeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(refreshTime), userInfo: nil, repeats: true)
        
        insulinTimer = Timer.scheduledTimer(timeInterval: 90, target: self, selector: #selector(refreshInsulin), userInfo: nil, repeats: false)
        
        batteryTimer = Timer.scheduledTimer(timeInterval: 175, target: self, selector: #selector(refreshBattery), userInfo: nil, repeats: false)
        
        insulinRemainingRefresh = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(refreshInsulinRemaining), userInfo: nil, repeats: true)
    }
    
    @objc func refreshInsulinRemaining() {
        insulinLeft.text = "\(viewModel.insulinLeft)U"
        insulinLeft.sizeToFit()
    }
    
    @objc func refreshTime() {
        timeLabel.text = viewModel.time
        timeLabel.sizeToFit()
    }
    
    @objc func refreshInsulin() {
        data.insulinLeft = data.insulinLeft - 0.1
        insulinLeft.text = "\(viewModel.insulinLeft)U"
        insulinLeft.sizeToFit()
    }
    
    @objc func refreshBattery() {
        data.batteryPercentage =  data.batteryPercentage - 5
        batteryLabel.text = "\(viewModel.batteryPercentage)%"
        batteryLabel.sizeToFit()
    }
}
