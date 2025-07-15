
import SwiftUI

struct StartCardView: View {
    let cardNumber: Int
    let category: TaskCategory
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Day card \(cardNumber)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 120, height: 30)
                    .background(Color.color4, in: .rect(cornerRadius: 50))
                
                Text(category.rawValue)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.color7)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            
            Image(category.imageName)
                .resizable()
                .frame(width: 95, height: 95)
                .padding(.trailing, 8)
        }
        .padding(12)
        .frame(height: 140)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.white, .color1]),
                startPoint: .leading,
                endPoint: .trailing
            ), in: .rect(cornerRadius: 20)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.white, lineWidth: 1)
        }
    }
}
