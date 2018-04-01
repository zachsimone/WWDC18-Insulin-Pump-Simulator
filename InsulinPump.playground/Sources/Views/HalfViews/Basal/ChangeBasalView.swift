import Foundation
import UIKit

public class ChangeBasalView: UIView {
    
    let basalViewModel = BasalViewModel()
    let basalLabel = UILabel()

    var currentBasal: Double = data.currentBasal
    
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
        basalLabel.text = "\(basalViewModel.currentBasal)\nU/h"
        basalLabel.sizeToFit()
    }
    
    func setupView() {
        backgroundColor = .gray
        layer.cornerRadius = Constants.HalfView.cornerRadius
    }
    
    func setupBasalLabel() {
        basalLabel.text = "\(basalViewModel.currentBasal)\nU/h"
        basalLabel.numberOfLines = 2
        basalLabel.font = basalLabel.font.withSize(30.0)
        basalLabel.textColor = .white
        basalLabel.sizeToFit()
        basalLabel.frame.origin.y = 35
        basalLabel.frame.origin.x = 120
        addSubview(basalLabel)
    }
    
    func setupButtons() {
        let upButton = UpButton(buttonAction: upButtonTapped)
        upButton.frame.origin.y = 30
        upButton.frame.origin.x = 204
        addSubview(upButton)
        
        let downButton = DownButton(buttonAction: downButtonTapped)
        downButton.frame.origin.y = 65
        downButton.frame.origin.x = 204
        addSubview(downButton)
        
        let saveButton = RectangularButton(
            frame: Constants.ButtonFrames.giveBolusButtonFrame,
            title: "Save new basal",
            buttonAction: saveBasal)
        saveButton.backgroundColor = Constants.Colours.background
        addSubview(saveButton)
    }
    
    func upButtonTapped() {
        currentBasal = (currentBasal + 0.1).rounded(toPlaces: 1)
        basalLabel.text = "\(currentBasal)\nU/h"
        basalLabel.sizeToFit()
    }
    
    func downButtonTapped() {
        guard currentBasal >= 0.1 else { return }
        currentBasal = (currentBasal - 0.1).rounded(toPlaces: 1)
        basalLabel.text = "\(currentBasal)\nU/h"
        basalLabel.sizeToFit()
    }
    
    @objc func saveBasal() {
        
        updateCurrentBasal(newBasal: currentBasal)
        
        UIView.animate(withDuration: Constants.Animation.animationDuration, animations: {
            self.alpha = 0.0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
}
