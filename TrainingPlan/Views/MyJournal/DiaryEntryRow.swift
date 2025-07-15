
import SwiftUI

struct DiaryEntryRow: View {
    let entry: DiaryEntry
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(dateFormatter.string(from: entry.date))
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.color1)
                
                Spacer()
                
                Text(entry.mood.rawValue)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.white)
            }
            
            Text(entry.text)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 20)
        .frame(minHeight: 70)
        .background(Color.color10, in: .rect(cornerRadius: 20))
    }
}
