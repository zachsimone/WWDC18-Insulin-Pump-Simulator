import Foundation

struct StatusBarViewModel {
    
    var batteryPercentage: Int {
        return data.batteryPercentage
    }
    
    var time: String {
        return currentTime()
    }
    
    var date: String {
        return currentDate()
    }
    
    var insulinLeft: Double {
        return data.insulinLeft
    }
}
