import SwiftUI

struct TodaysPowerView: View {
    @EnvironmentObject var userData: UserData
    @State private var quote: Quote = QuoteService.getRandomQuote()
    
    var body: some View {
        ZStack {
            Image(.bgMain)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                TitleView(title: "Today's Power")
                
                QuoteView(quote: quote)
                
                ScrollView {
                    if userData.selectedTaskIndex == nil {
                        VStack(spacing: 16) {
                            ForEach(0..<userData.dailyTasks.count, id: \.self) { index in
                                TaskCardView(
                                    cardNumber: index + 1,
                                    category: userData.dailyTasks[index].category,
                                    task: userData.dailyTasks[index]
                                )
                                .onTapGesture {
                                    withAnimation {
                                        if userData.dailyTasks[index].status != .completed {
                                            userData.selectTask(index: index)
                                        }
                                    }
                                    SoundManager.shared.playSound()
                                    VibroManager.shared.vibrate()
                                }
                            }
                        }
                        .padding(.bottom, 80)
                    } else {
                        if let selectedIndex = userData.selectedTaskIndex, selectedIndex < userData.dailyTasks.count {
                            SelectedCardView(task: userData.dailyTasks[selectedIndex])
                                .padding(.bottom, 80)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal, 16)
        }
        .onAppear {
            if userData.dailyTasks.isEmpty {
                userData.createNewDailyTasks()
            }
            
            quote = QuoteService.getRandomQuote()
        }
    }
}

#Preview {
    TodaysPowerView()
        .environmentObject(UserData())
}
