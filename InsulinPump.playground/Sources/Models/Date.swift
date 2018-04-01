import Foundation

func currentDate() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return(formatter.string(from: date))
}

func threeMinsAgo() -> Date {
    return Date().addingTimeInterval(-180) // 3 minutes ago
}

func justOverTwoHoursAgo() -> Date {
    return Date().addingTimeInterval(-7680) // 128 mins ago
}
