import SwiftUI

struct OnboardingContainerView: View {
    let onFinish: () -> Void
    @State private var selectedCategories: [TaskCategory] = []
    
    var body: some View {
        OnboardingWrapper(onFinish: { focusAreas in
            let categories = focusAreas.map { area -> TaskCategory in
                return TaskCategory(rawValue: area.name) ?? .mind
            }
            
            let userData = UserData()
            userData.saveSelectedCategories(categories)
            
            onFinish()
        })
    }
}

struct OnboardingWrapper: View {
    let onFinish: ([FocusArea]) -> Void
    @State private var selectedFocusAreas: Set<FocusArea> = []
    
    var body: some View {
        OnboardingView()
            .onPreferenceChange(SelectedFocusAreasPreferenceKey.self) { focusAreas in
                selectedFocusAreas = Set(focusAreas)
            }
            .onPreferenceChange(StartJourneyPreferenceKey.self) { shouldStart in
                if shouldStart {
                    onFinish(Array(selectedFocusAreas))
                }
            }
    }
}

struct SelectedFocusAreasPreferenceKey: PreferenceKey {
    static var defaultValue: [FocusArea] = []
    
    static func reduce(value: inout [FocusArea], nextValue: () -> [FocusArea]) {
        value = nextValue()
    }
}

struct StartJourneyPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = value || nextValue()
    }
}
