import Foundation
import UIKit

public class EnterBglCarbsBolusView: UIView {
    
    var bglLabel = UILabel()
    var carbsLabel = UILabel()
    var estimatedBolusLabel = UILabel()
    var bolusButton: RectangularButton?
    
    var bgl: Double?
    var carbs: Int = 0
    
    var estimatedBolus: Double?
    
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
        bgl = nil
        bglLabel.text = "--\nmmol/L"
        bglLabel.sizeToFit()
        
        carbs = 0
        carbsLabel.text = "0\ngrams"
        carbsLabel.sizeToFit()
        
        estimatedBolus = nil
        estimatedBolusLabel.text = "Estimated bolus: \(estimatedBolus ?? 0) units of insulin"
        
        guard bolusButton != nil else { return }
        bolusButton!.alpha = 0.5
        bolusButton!.isUserInteractionEnabled = false
    }
    
    func setupView() {
        backgroundColor = .gray
        layer.cornerRadius = Constants.HalfView.cornerRadius
    }
    
    func setupButtons() {
        let increaseBgl = UpButton(buttonAction: increaseBglButtonTapped)
        increaseBgl.frame.origin.y = 20
        increaseBgl.frame.origin.x = frame.width/5*2 - increaseBgl.frame.width/2 + 10
        addSubview(increaseBgl)
        
        let decreaseBgl = DownButton(buttonAction: decreaseBglButtonTapped)
        decreaseBgl.frame.origin.y = 55
        decreaseBgl.frame.origin.x = frame.width/5*2 - decreaseBgl.frame.width/2 + 10
        addSubview(decreaseBgl)
        
        
        let increaseCarbs = UpButton(buttonAction: increaseCarbsButtonTapped)
        increaseCarbs.frame.origin.y = 20
        increaseCarbs.frame.origin.x = frame.width/5*4 - increaseCarbs.frame.width/2 + 20
        addSubview(increaseCarbs)
        
        let decreaseCarbs = DownButton(buttonAction: decreaseCarbsButtonTapped)
        decreaseCarbs.frame.origin.y = 55
        decreaseCarbs.frame.origin.x = frame.width/5*4 - decreaseCarbs.frame.width/2 + 20
        addSubview(decreaseCarbs)
        
        bolusButton = RectangularButton(
            frame: Constants.ButtonFrames.giveBolusButtonFrame,
            title: "Give bolus insulin",
            buttonAction: bolus)
        bolusButton!.backgroundColor = Constants.Colours.background
        addSubview(bolusButton!)
    }
    
    func setupLabels() {
        bglLabel.text = "--\nmmol/L"
        bglLabel.numberOfLines = 2
        bglLabel.font = bglLabel.font.withSize(24.0)
        bglLabel.textColor = .white
        bglLabel.sizeToFit()
        bglLabel.frame.origin.y = 30
        bglLabel.frame.origin.x = frame.width/5 - bglLabel.frame.width/2 + 10
        addSubview(bglLabel)
        
        carbsLabel.text = "--\ngrams"
        carbsLabel.numberOfLines = 2
        carbsLabel.font = carbsLabel.font.withSize(24.0)
        carbsLabel.textColor = .white
        carbsLabel.sizeToFit()
        carbsLabel.frame.origin.y = 30
        carbsLabel.frame.origin.x = frame.width/5*3 - carbsLabel.frame.width/2 + 20
        addSubview(carbsLabel)
        
        estimatedBolusLabel.text = "Estimated bolus: \(estimatedBolus ?? 0) units of insulin"
        estimatedBolusLabel.textColor = .white
        estimatedBolusLabel.sizeToFit()
        estimatedBolusLabel.frame.origin.y = 100
        estimatedBolusLabel.frame.origin.x = frame.width/2 - estimatedBolusLabel.frame.width/2
        addSubview(estimatedBolusLabel)
    }
}

extension EnterBglCarbsBolusView {
    
    func increaseBglButtonTapped() {
        guard let level = bgl else {
            bgl = 6.0
            guard let newBgl = bgl else { return }
            bglLabel.text = "\(newBgl)\nmmol/L"
            bglLabel.sizeToFit()
            return
        }
        
        bgl = (level + 0.1).rounded(toPlaces: 1)
        guard let newBgl = bgl else { return }
        bglLabel.text = "\(newBgl)\nmmol/L"
        bglLabel.sizeToFit()
        
        estimateBolus()
    }
    
    func decreaseBglButtonTapped() {
        guard let level = bgl else {
            bgl = 6.0
            guard let newBgl = bgl else { return }
            bglLabel.text = "\(newBgl) \nmmol/L"
            bglLabel.sizeToFit()
            return 
        }
        
        guard level >= 0.1 else { return }
        
        bgl = (level - 0.1).rounded(toPlaces: 1)
        guard let newBgl = bgl else { return }
        bglLabel.text = "\(newBgl)\nmmol/L"
        bglLabel.sizeToFit()
        
        estimateBolus()
    }
    
    func increaseCarbsButtonTapped() {
        
        carbs = carbs + 1
        carbsLabel.text = "\(carbs)\ngrams"
        carbsLabel.sizeToFit()
        
        estimateBolus()
    }
    
    func decreaseCarbsButtonTapped() {
        
        guard carbs > 0 else { return }
        
        carbs = carbs - 1
        carbsLabel.text = "\(carbs)\ngrams"
        carbsLabel.sizeToFit()
        
        estimateBolus()
    }
    
    @objc func bolus() {
        estimateBolus()
        
        guard let bolus = estimatedBolus else { return }
        guard bolus > 0.0 else { return }

        let confirmView = BolusConfirmView(bolus: bolus, sender: self)
        addSubview(confirmView)
        
    }
    
    func estimateBolus() {
        
        let bolusFromBgl = ((bgl ?? 6.0) - 6.0) / 2.0
        let bolusFromCarbs = Double(carbs) / 7.0
        
        estimatedBolus = (bolusFromBgl + bolusFromCarbs).rounded(toPlaces: 1)
        estimatedBolusLabel.text = "Estimated bolus: \(estimatedBolus ?? 0) units of insulin"
        estimatedBolusLabel.sizeToFit()
        
        guard let estimate = estimatedBolus else { return }
        guard bolusButton != nil else { return }
        if estimate > 0.0 {
            bolusButton!.alpha = 1.0
            bolusButton!.isUserInteractionEnabled = true
        } else {
            bolusButton!.alpha = 0.5
            bolusButton!.isUserInteractionEnabled = false
        }
    }
}
