
import SwiftUI

struct SecondOnboardingView: View {
    var body: some View {
        VStack(spacing: 30) {
            Image("onboard2")
                .resizable()
                .scaledToFit()
                .padding(10)
            
            Text("Daily Challenges")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Text("Complete daily tasks tailored to your interests and track your progress")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
}
