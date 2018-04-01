import Foundation
import UIKit

public class DownButton: UIView {
    
    let closure: () -> ()
    
    public init(buttonAction: @escaping () -> ()) {
        self.closure = buttonAction
        
        // Frame is set later in setupButton()
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        setupButton()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        let downButton = UIButton()
        downButton.setTitle("⇧", for: .normal)
        downButton.titleLabel!.font = downButton.titleLabel!.font.withSize(26.0)
        downButton.sizeToFit()
        downButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        self.frame = downButton.frame
        downButton.addTarget(action, action: #selector(buttonTapped), for: .touchUpInside)
        
        downButton.addTarget(target, action: #selector(handleButtonTap), for: .touchDown)
        downButton.addTarget(target, action: #selector(handleTouchUp), for: .touchUpInside)
        downButton.addTarget(target, action: #selector(handleExit), for: .touchDragExit)
        
        addSubview(downButton)
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
