import Foundation
import UIKit

public class InfoHalfView: UIView {
    
    let descriptionText: String
    
    var descriptionLabel = UILabel()
    
    public init(description: String) {
        self.descriptionText = description
        
        super.init(frame: Constants.ButtonFrames.halfViewFrame)
        
        setupView()
        setupBackButton()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .gray
        layer.cornerRadius = Constants.HalfView.cornerRadius
        
        descriptionLabel.text = descriptionText
        descriptionLabel.font = descriptionLabel.font.withSize(14.0)
        descriptionLabel.textColor = .white
        descriptionLabel.frame = CGRect(x: Constants.Padding.largePadding,
            y: 30,
            width: Constants.HalfView.width - (Constants.Padding.largePadding*2),
            height: Constants.HalfView.height - (Constants.Padding.largePadding*4))
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        addSubview(descriptionLabel)
    }
    
    func setupBackButton() {
        let back = backButton(title: "< Dismiss")
        back.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        addSubview(back)
    }
    
    @objc func dismissView() {
        UIView.animate(withDuration: Constants.Animation.animationDuration, animations: {
            self.alpha = 0.0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
}
