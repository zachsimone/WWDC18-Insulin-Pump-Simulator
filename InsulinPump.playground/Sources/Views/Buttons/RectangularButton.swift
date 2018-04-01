import Foundation
import UIKit

public class RectangularButton: UIView {
    
    let titleString: String
    let closure: () -> ()
    
    let button = UIButton()

    public init(frame: CGRect, title: String, buttonAction: @escaping () -> ()) {
        self.titleString = title
        self.closure = buttonAction
        
        super.init(frame: frame)
        
        setupButton()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        
        backgroundColor = Constants.Colours.button
        
        layer.masksToBounds = true
        layer.cornerRadius = Constants.Buttons.cornerRadius
        
        let title = UILabel()
        title.text = titleString
        title.textColor = Constants.Colours.lighterText
        title.sizeToFit()
        title.frame.origin.y = self.frame.height/2 - title.frame.height/2
        title.frame.origin.x = self.frame.width/2 - title.frame.width/2
        addSubview(title)
        
        button.frame = CGRect(x: 0, y: 0, width: Constants.Buttons.rectangularButtonWidth, height: Constants.Buttons.rectangularButtonHeight)
        
        // Action
        button.addTarget(action, action: #selector(buttonTapped), for: .touchUpInside)
        
        // Handle tapping/releasing button
        button.addTarget(target, action: #selector(handleButtonTap), for: .touchDown)
        button.addTarget(target, action: #selector(handleTouchUp), for: .touchUpInside)
        button.addTarget(target, action: #selector(handleExit), for: .touchDragExit)
        
        addSubview(button)
    }
    
    @objc func buttonTapped() {
        closure()
    }
    
    @objc func handleButtonTap() {
        // User has tapped the button
        // Make it smaller as visual indication
        UIView.animate(withDuration: Constants.Animation.reallyShortDuration, animations: {
            self.transform = CGAffineTransform.init(scaleX: 0.96, y: 0.96)
        })
    }
    
    @objc func handleTouchUp() {
        // User has let go of the button
        // Return to full size
        // Take action
        UIView.animate(withDuration: Constants.Animation.normalDuration, animations: {
            self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        })
    }
    
    @objc func handleExit() {
        // User doesn't want to go through with the action
        // Bring icon back to full size, but do nothing else
        UIView.animate(withDuration: Constants.Animation.shortDuration, animations: {
            self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        })
    }
}
