
import SwiftUI

struct TitleView: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.white)
            .frame(height: 46)
            .frame(maxWidth: .infinity)
            .background(Color.color4, in: .rect(cornerRadius: 100))
            .padding(.top, 4)
    }
}
