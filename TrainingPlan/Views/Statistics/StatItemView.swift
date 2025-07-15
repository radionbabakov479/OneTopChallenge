
import SwiftUI

struct StatItem: Identifiable {
    let id = UUID()
    let title: String
    let value: String
}

struct StatItemView: View {
    let item: StatItem
    
    var body: some View {
        VStack(spacing: 2) {
            Text(item.title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white)
                .minimumScaleFactor(0.9)
                .lineLimit(2)
                .frame(height: 30)
            
            Text(item.value)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
        }
        .padding(10)
        .frame(width: 125, height: 114)
        .background(Color.white.opacity(0.1), in: .rect(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.white.opacity(0.2), lineWidth: 2)
        }
    }
}
