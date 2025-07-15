
import SwiftUI

struct FirstOnboardingView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("onboard1")
                .resizable()
                .scaledToFit()
                .padding(10)
            
            Text("Welcome to Training Plan")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Text("Your daily companion for personal growth and self-reflection")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding()
    }
}
