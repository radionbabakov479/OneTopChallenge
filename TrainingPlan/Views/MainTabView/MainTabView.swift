import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab = 0
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                TodaysPowerView()
                    .tag(0)
                
                MyJournalView()
                    .tag(1)
                
                TaskArchiveView()
                    .tag(2)
                
                StatisticsView()
                    .tag(3)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<4) { tab in
                Image(getIconName(for: tab, isSelected: selectedTab == tab))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        selectedTab = tab
                    }
            }
        }
        .background(
            Color.color5
                .clipShape(.rect(topLeadingRadius: 20, topTrailingRadius: 20))
                .ignoresSafeArea(edges: .bottom)
        )
        .padding(.horizontal, 8)
    }
    
    private func getIconName(for tab: Int, isSelected: Bool) -> String {
        return switch tab {
        case 0: isSelected ? "todaysPowerSelected" : "todaysPower"
        case 1: isSelected ? "myJournalSelected" : "myJournal"
        case 2: isSelected ? "taskArchiveSelected" : "taskArchive"
        case 3: isSelected ? "statisticSettingsSelected" : "statisticSettings"
        default: ""
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(UserData())
} 
