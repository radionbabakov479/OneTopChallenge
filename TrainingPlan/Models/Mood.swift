
import Foundation
import SwiftUI

enum Mood: String, Codable, CaseIterable, Identifiable {
    case veryGood = "Very Good"
    case good = "Good"
    case neutral = "Neutral"
    case bad = "Bad"
    case veryBad = "Very Bad"
    
    var id: String { self.rawValue }
    
    var icon: ImageResource {
        switch self {
        case .veryBad: .veryBad
        case .bad: .bad
        case .neutral: .neutral
        case .good: .good
        case .veryGood: .veryGood
        }
    }
}
