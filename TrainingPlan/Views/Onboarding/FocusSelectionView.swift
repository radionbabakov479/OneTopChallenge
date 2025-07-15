
import SwiftUI
// Экран выбора фокуса
struct FocusSelectionView: View {
    @Binding var selectedFocusAreas: Set<FocusArea>
    let focusAreas: [FocusArea]
    let onStartJourney: () -> Void
    let onBack: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Choose Your Focus Areas")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(height: 46)
                .frame(maxWidth: .infinity)
                .background(Color.color4, in: .rect(cornerRadius: 100))
                .padding(.top, 4)
            
            VStack(spacing: 14) {
                HStack(spacing: 14) {
                    FocusAreaView(
                        area: focusAreas[0],
                        isSelected: selectedFocusAreas.contains(focusAreas[0]),
                        onTap: { toggleFocusArea(focusAreas[0]) }
                    )
                    
                    FocusAreaView(
                        area: focusAreas[1],
                        isSelected: selectedFocusAreas.contains(focusAreas[1]),
                        onTap: { toggleFocusArea(focusAreas[1]) }
                    )
                }
                
                HStack(spacing: 14) {
                    FocusAreaView(
                        area: focusAreas[2],
                        isSelected: selectedFocusAreas.contains(focusAreas[2]),
                        onTap: { toggleFocusArea(focusAreas[2]) }
                    )
                    
                    FocusAreaView(
                        area: focusAreas[3],
                        isSelected: selectedFocusAreas.contains(focusAreas[3]),
                        onTap: { toggleFocusArea(focusAreas[3]) }
                    )
                }
                
                HStack(spacing: 14) {
                    FocusAreaView(
                        area: focusAreas[4],
                        isSelected: selectedFocusAreas.contains(focusAreas[4]),
                        onTap: { toggleFocusArea(focusAreas[4]) }
                    )
                    
                    Button(action: onStartJourney) {
                        Text("Start My Journey!")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Image(.bgButton).resizable())
                    }
                    .disabled(selectedFocusAreas.isEmpty)
                    .opacity(selectedFocusAreas.isEmpty ? 0.5 : 1)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .padding(.bottom, 8)
        }
        .padding(.horizontal, 20)
    }
    
    private func toggleFocusArea(_ area: FocusArea) {
        withAnimation {
            if selectedFocusAreas.contains(area) {
                selectedFocusAreas.remove(area)
            } else {
                selectedFocusAreas.insert(area)
            }
        }
    }
}

struct FocusArea: Hashable {
    let id: String
    let name: String
    let imageName: String
}

struct FocusAreaView: View {
    let area: FocusArea
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 14) {
                Image(area.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Text(area.name)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(isSelected ? Color.color2 : .color1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(isSelected ? Color.color3 : Color.white,
                                    lineWidth: isSelected ? 3 : 1)
                    )
            )
        }
    }
}

#Preview {
    ZStack {
        Image(.bgOnboard)
            .resizable()
            .ignoresSafeArea()
        
        FocusSelectionView(selectedFocusAreas: .constant([]), focusAreas: [
            FocusArea(id: "mind", name: "Mind", imageName: "mind"),
            FocusArea(id: "sport", name: "Sport", imageName: "sport"),
            FocusArea(id: "health", name: "Health", imageName: "health"),
            FocusArea(id: "nutrition", name: "Nutrition", imageName: "nutrition"),
            FocusArea(id: "mental", name: "Mental", imageName: "mental")
        ], onStartJourney: {}, onBack: {})
    }
}
