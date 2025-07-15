
import SwiftUI

struct QuoteView: View {
    
    let quote: Quote
    
    var body: some View {
        HStack(spacing: 20) {
            Image("lamp")
                .resizable()
                .frame(width: 75, height: 75)
                        
            VStack(alignment: .leading, spacing: 10) {
                Text("\"\(quote.text)\"")
                    .font(.headline)
                    .foregroundColor(.white)
                
                    Text(quote.author)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                        .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(16)
        .frame(minHeight: 148)
        .background(Color.color6, in: .rect(cornerRadius: 20))
    }
}
