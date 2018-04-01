import Foundation
import UIKit

public func screenTitle(title: String) -> UILabel {
    let titleLabel = UILabel()
    titleLabel.text = title
    titleLabel.textColor = .white
    titleLabel.font = titleLabel.font.withSize(16.0)
    titleLabel.sizeToFit()
    titleLabel.frame.origin.y = Constants.Padding.mediumPadding
    titleLabel.frame.origin.x = Constants.Padding.mediumPadding
    return titleLabel
}

public func backButton(title: String) -> UIButton {
    let backButton = UIButton()
    backButton.setTitle(title, for: .normal)
    backButton.sizeToFit()
    backButton.frame.origin.y = 0
    backButton.frame.origin.x = Constants.Padding.smallPadding
    return backButton
}

public func infoButton() -> UIButton {
    let infoButton = UIButton()
    infoButton.setTitle("ℹ︎", for: .normal)
    infoButton.sizeToFit()
    infoButton.frame.origin.y = 0
    infoButton.frame.origin.x = CGFloat(Constants.ScreenView.width) - CGFloat(infoButton.frame.width) - CGFloat(Constants.Padding.smallPadding)
    return infoButton
}
