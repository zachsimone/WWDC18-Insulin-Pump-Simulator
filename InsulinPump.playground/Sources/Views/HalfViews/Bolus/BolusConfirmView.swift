import Foundation
import UIKit

public class BolusConfirmView: UIView {
    
    var bolusAmount: Double!
    var sender: UIView!
    
    // UI elements
    let confirmLabel = UILabel()
    var confirmButton: RectangularButton?
    var cancelButton: RectangularButton?
    
    public init(bolus: Double, sender: UIView) {

        self.bolusAmount = bolus
        self.sender = sender
        
        super.init(frame: CGRect(x: 0, y: 0, width: Constants.HalfView.width, height: Constants.HalfView.height))
        
        setupView()
        setupLabels()
        setupButtons()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .gray
        layer.cornerRadius = Constants.HalfView.cornerRadius
    }
    
    func setupButtons() {
        
        confirmButton = RectangularButton(
            frame: Constants.ButtonFrames.yesButton,
            title: "Yes",
            buttonAction: giveBolus)
        
        guard confirmButton != nil else { return }
        confirmButton!.backgroundColor = Constants.Colours.background
        addSubview(confirmButton!)
        
        cancelButton = RectangularButton(
            frame: Constants.ButtonFrames.noButton,
            title: "No",
            buttonAction: cancel)
        
        guard cancelButton != nil else { return }
        cancelButton!.backgroundColor = Constants.Colours.background
        addSubview(cancelButton!)
        
    }
    
    func setupLabels() {
        
        guard let bolus = bolusAmount else { return }
        
        confirmLabel.text = "Confirm\nDeliver \(bolus) units of insulin?"
        confirmLabel.numberOfLines = 2
        confirmLabel.textColor = .white
        confirmLabel.sizeToFit()
        confirmLabel.frame.origin.y = 20
        confirmLabel.frame.origin.x = 30
        addSubview(confirmLabel)
    }
    
    @objc func giveBolus() {
        
        guard let bolus = bolusAmount else { return }
        confirmLabel.text = "Delivering \(bolus) units..."
        confirmLabel.sizeToFit()
        confirmLabel.frame.origin.x = frame.width/2 - confirmLabel.frame.width/2
        confirmLabel.frame.origin.y = frame.height/3 - confirmLabel.frame.height/2
        
        let sliderY = frame.height/3*2 - 15

        let sliderBackgroundView = UIView()
        sliderBackgroundView.backgroundColor = UIColor(white: 1, alpha: 0.1)
        sliderBackgroundView.frame = CGRect(x: 20,
                                            y: sliderY,
                                            width: frame.width - 40,
                                            height: 30)
        addSubview(sliderBackgroundView)
        
        let sliderView = UIView()
        sliderView.backgroundColor = .white
        sliderView.frame = CGRect(x: 20,
                                  y: sliderY,
                                  width: 1,
                                  height: 30)
        
        addSubview(sliderView)
        
        if confirmButton != nil || cancelButton != nil {
            confirmButton!.alpha = 0.0
            cancelButton!.alpha = 0.0
        }
        
        // Take bolus amount away from insulin remaining on the pump (the value in the top left of the status bar)
        subtractFromInsulinRemaining(units: bolus)
        //Add bolus amount to active active insulin
        addActiveInsulin(units: bolus)

        UIView.animate(withDuration: 4.0, delay: Constants.Animation.normalDelay, options: .curveEaseIn, animations: {
            sliderView.frame = CGRect(x: 20,
                                      y: sliderY,
                                      width: self.frame.width - 40,
                                      height: 30)
        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.removeFromSuperview()
                self.sender.removeFromSuperview()
            })
        })
    }
    
    @objc func cancel() {
        removeFromSuperview()
    }
}
