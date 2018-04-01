import Foundation

public class SharedData {
    var batteryPercentage = 100

    var insulinLeft = 370.0
    var activeInsulin = 1.2
    
    var currentBasal = 1.80
    
    var lastBgl = 6.1
    var lastBglTime = timeThreeMinsAgo()
    
    var bolusHistoryTimes = [
                            "11:57 AM",
                            "4:20 PM",
                            "6:31 PM",
                            "6:09 AM",
                            timeJustOverTwoHoursAgo()]
    
    var bolusHistoryAmounts = [
                        "9.0 units",
                        "1.5 units",
                        "4.8 units",
                        "3.1 units",
                        "4.9 units"]
}

let data = SharedData()
