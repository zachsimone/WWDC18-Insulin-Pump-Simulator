import Foundation
import UIKit

class GraphView: UIView {
    
    let lineChart = LineChart()

    let currentBglLabel = UILabel()
    let currentBglTextLabel = UILabel()
    
    let averageBglLabel = UILabel()
    let averageBglTextLabel = UILabel()
    
    let targetBglLabel = UILabel()
    let targetBglTextLabel = UILabel()
    
    let infoHalfView = InfoHalfView(description: Constants.GraphPageDescription.description)

    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLabels()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = Constants.Colours.background

        addSubview(screenTitle(title: "Blood glucose - Last three hours"))
        
        let info = infoButton()
        info.addTarget(action, action: #selector(infoButtonTapped), for: .touchUpInside)
        addSubview(info)

        lineChart.backgroundColor = Constants.Colours.background

        lineChart.frame = CGRect(x: 0, y: 30, width: Constants.PageView.width - 150, height: Constants.PageView.height - 50)
        lineChart.plot(rawGlucoseData)
        addSubview(lineChart)
    }
    
    func setupLabels() {
        currentBglLabel.text = "\(data.lastBgl) mmol/L"
        currentBglLabel.textColor = .white
        currentBglLabel.font = currentBglLabel.font.withSize(18.0)
        currentBglLabel.sizeToFit()
        currentBglLabel.frame.origin.y = 50
        currentBglLabel.frame.origin.x = lineChart.frame.width
        addSubview(currentBglLabel)
        
        currentBglTextLabel.text = "current BGL"
        currentBglTextLabel.textColor = .white
        currentBglTextLabel.font = currentBglTextLabel.font.withSize(16.0)
        currentBglTextLabel.sizeToFit()
        currentBglTextLabel.frame.origin.y = 75
        currentBglTextLabel.frame.origin.x = lineChart.frame.width
        addSubview(currentBglTextLabel)

        averageBglLabel.text = "6.7 mmol/L"
        averageBglLabel.textColor = .white
        averageBglLabel.font = averageBglLabel.font.withSize(18.0)
        averageBglLabel.sizeToFit()
        averageBglLabel.frame.origin.y = 110
        averageBglLabel.frame.origin.x = lineChart.frame.width
        addSubview(averageBglLabel)

        averageBglTextLabel.text = "average today"
        averageBglTextLabel.textColor = .white
        averageBglTextLabel.font = averageBglTextLabel.font.withSize(16.0)
        averageBglTextLabel.sizeToFit()
        averageBglTextLabel.frame.origin.y = 135
        averageBglTextLabel.frame.origin.x = lineChart.frame.width
        addSubview(averageBglTextLabel)

        targetBglLabel.text = "3.9 - 7.9 mmol/L"
        targetBglLabel.textColor = .white
        targetBglLabel.font = targetBglLabel.font.withSize(18.0)
        targetBglLabel.sizeToFit()
        targetBglLabel.frame.origin.y = 160
        targetBglLabel.frame.origin.x = lineChart.frame.width
        addSubview(targetBglLabel)

        targetBglTextLabel.text = "target BGL"
        targetBglTextLabel.textColor = .white
        targetBglTextLabel.font = targetBglTextLabel.font.withSize(16.0)
        targetBglTextLabel.sizeToFit()
        targetBglTextLabel.frame.origin.y = 185
        targetBglTextLabel.frame.origin.x = lineChart.frame.width
        addSubview(targetBglTextLabel)
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
