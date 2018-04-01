import Foundation
import UIKit

public class ManualBolusView: UIView {
    
    var bolusAmount: Double = 0

    var insulinAmountLabel = UILabel()
    var bolusButton: RectangularButton?
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: Constants.HalfView.width, height: Constants.HalfView.height))
        
        setupView()
        setupButtons()
        setupLabels()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        bolusAmount = 0
        insulinAmountLabel.text = "-- units"
        insulinAmountLabel.sizeToFit()
        
        guard bolusButton != nil else { return }
        bolusButton!.alpha = 0.5
        bolusButton!.isUserInteractionEnabled = false
    }
    
    func setupView() {
        backgroundColor = .gray
        layer.cornerRadius = Constants.HalfView.cornerRadius
    }
    
    func setupButtons() {
        
        let increaseInsulin = UpButton(buttonAction: increaseInsulinButtonTapped)
        increaseInsulin.frame.origin.y = 30
        increaseInsulin.frame.origin.x = 204
        addSubview(increaseInsulin)
        
        let decreaseInsulin = DownButton(buttonAction: decreaseInsulinButtonTapped)
        decreaseInsulin.frame.origin.y = 65
        decreaseInsulin.frame.origin.x = 204
        addSubview(decreaseInsulin)
        
        bolusButton = RectangularButton(
            frame: Constants.ButtonFrames.giveBolusButtonFrame,
            title: "Give bolus insulin",
            buttonAction: bolus)
        guard bolusButton != nil else { return }
        bolusButton!.backgroundColor = Constants.Colours.background
        addSubview(bolusButton!)
    }
    
    func setupLabels() {
        insulinAmountLabel.text = "-- \nunits"
        insulinAmountLabel.numberOfLines = 2
        insulinAmountLabel.font = insulinAmountLabel.font.withSize(30.0)
        insulinAmountLabel.textColor = .white
        insulinAmountLabel.sizeToFit()
        insulinAmountLabel.frame.origin.y = 35
        insulinAmountLabel.frame.origin.x = 120
        addSubview(insulinAmountLabel)
    }
    
    @objc func bolus() {
        estimateBolus()

        guard bolusAmount > 0.0 else { return }
        
        let confirmView = BolusConfirmView(bolus: bolusAmount, sender: self)
        addSubview(confirmView)
    }
    
    func increaseInsulinButtonTapped() {
        
        bolusAmount = (bolusAmount + 0.1).rounded(toPlaces: 1)
        insulinAmountLabel.text = "\(bolusAmount) units"
        insulinAmountLabel.sizeToFit()
        
        estimateBolus()
    }
    
    func decreaseInsulinButtonTapped() {
        guard bolusAmount > 0 else { return }
        
        bolusAmount = (bolusAmount - 0.1).rounded(toPlaces: 1)
        insulinAmountLabel.text = "\(bolusAmount) units"
        insulinAmountLabel.sizeToFit()
        
        estimateBolus()
    }
    
    func estimateBolus() {
        
        guard bolusButton != nil else { return }
        if bolusAmount > 0.0 {
            bolusButton!.alpha = 1.0
            bolusButton!.isUserInteractionEnabled = true
        } else {
            bolusButton!.alpha = 0.5
            bolusButton!.isUserInteractionEnabled = false
        }
    }
}
