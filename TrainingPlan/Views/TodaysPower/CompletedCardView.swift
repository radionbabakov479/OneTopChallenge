
import SwiftUI

struct CompletedCardView: View {
    let cardNumber: Int
    let category: TaskCategory
    let task: DailyTask
    let isCompleted: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .top) {
                    Text("Day card \(cardNumber)")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 120, height: 30)
                        .background(Color.color4, in: .rect(cornerRadius: 50))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(category.imageName)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                
                Text(isCompleted ? "Completed!" : "Not Completed")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
        .padding(12)
        .frame(height: 140)
        .background(isCompleted ? Color.color5 : Color.color4, in: .rect(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.white, lineWidth: 1)
        }
    }
}
