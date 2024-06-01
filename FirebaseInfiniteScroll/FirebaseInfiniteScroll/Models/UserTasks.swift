import SwiftUI
import FirebaseFirestore

struct UserTasks: Identifiable, Codable {
    @DocumentID var id: String?
    var createdAt: Date
    var title: String
    
    init(createdAt: Date = .now, title: String = "Unknowed: \(UUID().uuidString)") {
        self.createdAt = createdAt
        self.title = title
    }
}
