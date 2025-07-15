import Foundation

enum TaskCategory: String, Codable, CaseIterable, Identifiable {
    case mind = "Mind"
    case sport = "Sport"
    case health = "Health"
    case nutrition = "Nutrition"
    case mental = "Mental"
    
    var id: String { self.rawValue }
    
    var imageName: String {
        return self.rawValue.lowercased()
    }
}

enum TaskStatus: String, Codable {
    case notStarted = "Not Started"
    case select = "Select"
    case completed = "Completed"
    case didNotComplete = "Did Not Complete"
}

struct DailyTask: Identifiable, Codable, Hashable {
    let id: UUID
    let category: TaskCategory
    let text: String
    var status: TaskStatus
    let date: Date
    var isCompleate: Bool
    
    init(id: UUID = UUID(), category: TaskCategory, text: String, status: TaskStatus = .notStarted, date: Date = Date(), isCompleate: Bool = false) {
        self.id = id
        self.category = category
        self.text = text
        self.status = status
        self.date = date
        self.isCompleate = isCompleate
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(date)
        hasher.combine(text)
    }
    
    static func == (lhs: DailyTask, rhs: DailyTask) -> Bool {
        return lhs.id == rhs.id &&
               lhs.date == rhs.date &&
               lhs.text == rhs.text &&
               lhs.category == rhs.category &&
               lhs.status == rhs.status &&
               lhs.isCompleate == rhs.isCompleate
    }
}

class TaskService {
    static let tasks: [TaskCategory: [String]] = [
        .mind: [
            "Spend 15 minutes meditating today",
            "Learn 5 new words in a foreign language",
            "Read a chapter from a non-fiction book",
            "Solve a puzzle or brain teaser",
            "Write down three things you're grateful for"
        ],
        .sport: [
            "Do 20 push-ups and 20 sit-ups",
            "Go for a 20-minute walk or jog",
            "Stretch for 10 minutes",
            "Try a new workout routine",
            "Practice balance exercises for 5 minutes"
        ],
        .health: [
            "Drink at least 8 glasses of water today",
            "Get 7-8 hours of sleep tonight",
            "Take a break from screens for 1 hour",
            "Eat a serving of fruits and vegetables with each meal",
            "Practice deep breathing for 5 minutes"
        ],
        .nutrition: [
            "Eat a healthy breakfast with protein",
            "Try a new healthy recipe",
            "Avoid sugary drinks today",
            "Prepare a meal plan for the week",
            "Replace one processed snack with a fruit or vegetable"
        ],
        .mental: [
            "Practice mindfulness for 10 minutes",
            "Write in a journal about your feelings",
            "Do something creative today",
            "Call or message a friend or family member",
            "Take a 15-minute break to do something you enjoy"
        ]
    ]
    
    static func getRandomTask(for category: TaskCategory) -> DailyTask {
        guard let categoryTasks = tasks[category], !categoryTasks.isEmpty else {
            return DailyTask(category: category, text: "Default task for \(category.rawValue)")
        }
        
        let randomText = categoryTasks.randomElement()!
        return DailyTask(category: category, text: randomText)
    }
    
    static func getRandomTask(from categories: [TaskCategory]) -> DailyTask {
        guard !categories.isEmpty else {
            return DailyTask(category: .mind, text: "Default task")
        }
        
        let randomCategory = categories.randomElement()!
        return getRandomTask(for: randomCategory)
    }
} 
