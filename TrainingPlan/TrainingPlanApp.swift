
import SwiftUI

//@main
//struct TrainingPlanApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

struct ContentView: View {
    
    @StateObject private var userData = UserData()
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    var body: some View {
        VStack {
            if hasCompletedOnboarding {
                MainTabView()
                    .environmentObject(userData)
            } else {
                OnboardingContainerView(onFinish: {
                    hasCompletedOnboarding = true
                })
            }
        }
        .onAppear {
            AppDelegate.orientationLock = .portrait
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }
    }
}

#Preview {
    ContentView()
}
