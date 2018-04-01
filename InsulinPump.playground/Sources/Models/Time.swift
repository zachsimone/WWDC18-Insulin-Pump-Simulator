import Foundation

func currentTime() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return(formatter.string(from: date))
}

func currentHourInDay() -> Int {
    return Calendar.current.component(.hour, from: Date())
}

func timeThreeMinsAgo() -> String {
    let date = threeMinsAgo()
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return(formatter.string(from: date))
}

func timeJustOverTwoHoursAgo() -> String {
    let date = justOverTwoHoursAgo()
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return(formatter.string(from: date))
}
