
import SwiftUI

struct TaskCardView: View {
    
    let cardNumber: Int
    let category: TaskCategory
    let task: DailyTask
    
    var body: some View {
        switch task.status {
        case .notStarted:
            StartCardView(cardNumber: cardNumber, category: category)
        case .select:
            SelectedCardView(task: task)
        case .completed:
            CompletedCardView(cardNumber: cardNumber, category: category, task: task, isCompleted: true)
        case .didNotComplete:
            CompletedCardView(cardNumber: cardNumber, category: category, task: task, isCompleted: false)
        }
    }
}
