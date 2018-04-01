import Foundation
import UIKit

public class InfoBox: UIView {
    
    let titleString: String
    let valueString: String
    let emojiString: String
    
    let emoji = UILabel()
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    
    public init(title: String, value: String, emoji: String) {
        self.titleString = title
        self.valueString = value
        self.emojiString = emoji
        
        super.init(frame: CGRect(x: 0, y: 0, width: Constants.InfoBox.boxWidth, height: Constants.InfoBox.boxHeight))
        
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        backgroundColor = .clear
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        
        emoji.textColor = .white
        emoji.text = emojiString
        emoji.font = emoji.font.withSize(36.0)
        emoji.sizeToFit()
        emoji.frame.size.height = self.frame.height
        emoji.frame.origin.x = Constants.Padding.largePadding
        addSubview(emoji)
        
        titleLabel.textColor = .white
        titleLabel.text = titleString
        titleLabel.font = titleLabel.font.withSize(14.0)
        titleLabel.sizeToFit()
        titleLabel.frame.size.height = self.frame.height/2 - 10
        titleLabel.frame.origin.y = 10
        titleLabel.frame.origin.x = Constants.Padding.largePadding*2 + emoji.frame.width
        addSubview(titleLabel)
        
        valueLabel.textColor = .white
        valueLabel.text = valueString
        valueLabel.font = valueLabel.font.withSize(14.0)
        valueLabel.sizeToFit()
        valueLabel.frame.size.height = self.frame.height/2 - 10
        valueLabel.frame.origin.y = self.frame.height/2
        valueLabel.frame.origin.x = Constants.Padding.largePadding*2 + emoji.frame.width
        addSubview(valueLabel)
    }
    
    public func updateValue(newValue: String) {
        valueLabel.text = newValue
        valueLabel.sizeToFit()
    }
}
