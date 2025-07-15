
import Foundation
import SwiftUI

struct DiaryEntry: Identifiable, Codable {
    let id: UUID
    let text: String
    let date: Date
    let mood: Mood
    
    init(id: UUID = UUID(), text: String, date: Date = Date(), mood: Mood = .neutral) {
        self.id = id
        self.text = text
        self.date = date
        self.mood = mood
    }
}
