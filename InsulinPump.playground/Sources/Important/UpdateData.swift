import Foundation


func updateCurrentBasal(newBasal: Double) {
    data.currentBasal = newBasal
}

func addActiveInsulin(units: Double) {
    data.activeInsulin = data.activeInsulin + units
    
    // Add to bolus history array(s)
    data.bolusHistoryTimes.append(currentTime())
    data.bolusHistoryAmounts.append("\(units) units")
}

func subtractFromInsulinRemaining(units: Double) {
    guard data.insulinLeft - units > 0.0 else { return }
    data.insulinLeft = data.insulinLeft - units
}
