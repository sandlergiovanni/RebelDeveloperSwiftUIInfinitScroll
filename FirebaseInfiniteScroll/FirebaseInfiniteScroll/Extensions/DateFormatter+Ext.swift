import Foundation

extension DateFormatter {
    static let displayMinutesAndSeconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        return formatter
    }()
}
