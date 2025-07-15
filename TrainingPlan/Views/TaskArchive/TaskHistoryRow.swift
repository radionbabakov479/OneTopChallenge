
import SwiftUI

struct TaskHistoryRow: View {
    let task: DailyTask
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter
    }()
    
    var body: some View {
        HStack(spacing: 16) {
            Image(task.category.imageName)
                .resizable()
                .frame(width: 56, height: 56)
            
            VStack(spacing: 4) {
                HStack(spacing: 16) {
                    Text(dateFormatter.string(from: task.date))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.color1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(task.isCompleate ? "Complited" : "Not Complited")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 120, height: 30)
                        .background(task.isCompleate ? Color.color3 : .color11, in: .rect(cornerRadius: 50))
                }
                
                Text(task.text)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .frame(height: 107)
        .background(Color.color10, in: .rect(cornerRadius: 20))
    }
}
