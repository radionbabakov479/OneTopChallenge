
import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var selectedFocusAreas: Set<FocusArea> = []
    @State private var showFocusSelection = false
    @State private var startJourney = false
    
    private let focusAreas = [
        FocusArea(id: "mind", name: "Mind", imageName: "mind"),
        FocusArea(id: "health", name: "Health", imageName: "health"),
        FocusArea(id: "sport", name: "Sport", imageName: "sport"),
        FocusArea(id: "nutrition", name: "Nutrition", imageName: "nutrition"),
        FocusArea(id: "mental", name: "Mental", imageName: "mental")
    ]
    
    var body: some View {
        ZStack {
            Image(.bgOnboard)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                if !showFocusSelection {
                    VStack {
                        TabView(selection: $currentPage) {
                            FirstOnboardingView()
                                .tag(0)
                            
                            SecondOnboardingView()
                                .tag(1)
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .animation(.easeInOut, value: currentPage)
                        
                        VStack(spacing: 40) {
                            HStack(spacing: 10) {
                                ForEach(0..<3, id: \.self) { index in
                                    Rectangle()
                                        .fill(currentPage == index ? Color.white : Color.white.opacity(0.3))
                                        .frame(width: 40, height: 6)
                                        .cornerRadius(10)
                                }
                            }
                            
                            Button(action: {
                                if currentPage < 1 {
                                    currentPage += 1
                                } else {
                                    showFocusSelection = true
                                }
                            }) {
                                Text("NEXT")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(width: 164, height: 50)
                                    .background(Image(.bgButton).resizable())
                            }
                            
                            Button(action: {
                                showFocusSelection = true
                            }) {
                                Text("Skip")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .padding(.bottom, 20)
                        }
                    }
                    .transition(.move(edge: .leading))
                } else {
                    FocusSelectionView(
                        selectedFocusAreas: $selectedFocusAreas,
                        focusAreas: focusAreas,
                        onStartJourney: {
                            startJourney = true
                        },
                        onBack: {
                            showFocusSelection = false
                        }
                    )
                    .transition(.move(edge: .trailing))
                }
            }
            .animation(.default, value: showFocusSelection)
        }
        .preference(key: SelectedFocusAreasPreferenceKey.self, value: Array(selectedFocusAreas))
        .preference(key: StartJourneyPreferenceKey.self, value: startJourney)
    }
}

#Preview {
    OnboardingView()
}
