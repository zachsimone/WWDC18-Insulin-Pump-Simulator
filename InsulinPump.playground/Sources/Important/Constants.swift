import UIKit

struct Constants {
    
    enum Padding {
        static let extraSmallPadding = CGFloat(2.0)
        static let smallPadding = CGFloat(4.0)
        static let mediumPadding = CGFloat(8.0)
        static let largePadding = CGFloat(12.0)
    }
    
    enum Animation {
        static let reallyShortDuration = 0.001
        static let shortDuration = 0.01
        static let normalDuration = 0.1
        
        static let animationDuration = 0.3
        
        static let normalDelay = 0.2
    }
    
    enum MainView {
        static let width = 520.0
        static let height = 400.0
    }
    
    enum ScreenView {
        static let width = MainView.width - 140
        static let height = MainView.height - 140
        
        static let cornerRadius = CGFloat(4.0)
    }
    
    enum InfoBox {
        static let boxWidth = CGFloat(Constants.ScreenView.width/2 - 18)
        static let boxHeight = CGFloat(80.0)
    }
    
    enum BlackFrame {
        static let width = Constants.ScreenView.width + 20
        static let height = Constants.ScreenView.height + 20
        
        static let cornerRadius = CGFloat(14.0)
    }
    
    enum GrayFrame {
        static let width = Constants.BlackFrame.width + 10
        static let height = Constants.BlackFrame.height + 10
        
        static let cornerRadius = CGFloat(16.0)
    }
    
    enum HalfView {
        static let width = CGFloat(ScreenView.width - 20)
        static let height = CGFloat(ScreenView.height - 76)
        
        static let cornerRadius = CGFloat(8.0)
    }
    
    enum StatusBar {
        static let height = 24.0
    }
    
    enum PageView {
        static let numberOfPages = 4
        
        static let width = Constants.ScreenView.width
        static let height = Constants.ScreenView.height - StatusBar.height
    }
    
    enum PageControl {
        static let width = 200.0
        static let height = 20.0
    }
    
    enum Buttons {
        static let rectangularButtonWidth = 300.0
        static let rectangularButtonHeight = 40.0
        
        static let squareButtonWidth = 120.0
        static let squareButtonHeight = 120.0
        static let longSquareButtonWidth = 146.0
        
        static let cornerRadius = CGFloat(8.0)
    }
    
    enum ButtonFrames {
        static let manualBolusButtonFrame = CGRect(x: Double(viewBasalsButtonFrame.origin.x + 154),
                                                   y: 40.0,
                                                   width: Constants.Buttons.longSquareButtonWidth,
                                                   height: Constants.Buttons.squareButtonHeight)
        
        static let enterBglCarbsButtonFrame = CGRect(x: Double(viewBasalsButtonFrame.origin.x),
                                                     y: 40.0,
                                                     width: Constants.Buttons.longSquareButtonWidth,
                                                     height: Constants.Buttons.squareButtonHeight)
        
        static let editBasalButtonFrame = CGRect(x: Double(viewBasalsButtonFrame.origin.x),
                                                 y: 40.0,
                                                 width: Constants.Buttons.longSquareButtonWidth,
                                                 height: Constants.Buttons.squareButtonHeight)
        static let setTemporaryBasalButtonFrame = CGRect(x: Double(viewBasalsButtonFrame.origin.x + 154),
                                                         y: 40.0,
                                                         width: Constants.Buttons.longSquareButtonWidth,
                                                         height: Constants.Buttons.squareButtonHeight)
        
        static let viewBasalsButtonFrame = CGRect(x: Constants.ScreenView.width/2 - Constants.Buttons.rectangularButtonWidth/2, y: 168.0, width: Constants.Buttons.rectangularButtonWidth, height: Constants.Buttons.rectangularButtonHeight)
        
        static let viewBolusHistoryButtonFrame = CGRect(x: Constants.ScreenView.width/2 - Constants.Buttons.rectangularButtonWidth/2, y: 168.0, width: Constants.Buttons.rectangularButtonWidth, height: Constants.Buttons.rectangularButtonHeight)
        
        static let giveBolusButtonFrame = CGRect(x: Double(Constants.HalfView.width/2.0) - Constants.Buttons.rectangularButtonWidth/2, y: 130.0, width: Constants.Buttons.rectangularButtonWidth, height: Constants.Buttons.rectangularButtonHeight)
        
        static let noButton = CGRect(x: Double(Constants.HalfView.width/2.0) - Constants.Buttons.rectangularButtonWidth/2, y: 130.0, width: Constants.Buttons.rectangularButtonWidth, height: Constants.Buttons.rectangularButtonHeight)
        
        static let yesButton = CGRect(x: Double(Constants.HalfView.width/2.0) - Constants.Buttons.rectangularButtonWidth/2, y: 80.0, width: Constants.Buttons.rectangularButtonWidth, height: Constants.Buttons.rectangularButtonHeight)

        static let halfViewFrame = CGRect(x: CGFloat(Constants.PageView.width)/2 - Constants.HalfView.width/2,
                                          y: CGFloat(Constants.PageView.height/2) - CGFloat(Constants.HalfView.height/2),
                                          width: Constants.HalfView.width,
                                          height: Constants.HalfView.height)
    }
    
    enum Colours {
        static let background = UIColor(red:0.16, green:0.16, blue:0.16, alpha:1.0)
        static let button = UIColor(red:0.50, green:0.50, blue:0.50, alpha:1.0)
        
        static let lighterText = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.85)
    }
}
