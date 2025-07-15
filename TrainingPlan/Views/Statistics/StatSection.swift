
import SwiftUI

struct StatSection: View {
    let title: String
    let stats: [StatItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .padding(.leading, 20)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(stats) { stat in
                        StatItemView(item: stat)
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
    }
}
