import SwiftUI

struct StatisticsView: View {
    
    @EnvironmentObject var userData: UserData
    
    @AppStorage("isSoundEnabled") private var isSoundEnabled = true
    @AppStorage("isVibroEnabled") private var isVibroEnabled = true
    
    var body: some View {
        ZStack {
            Image(.bgMain)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                TitleView(title: "Statistic & Settings")
                    .padding(.horizontal, 16)
                
                ScrollView {
                    VStack(spacing: 20) {
                        StatSection(title: "Streak statistics", stats: [
                            StatItem(title: "Days with Completed Tasks", value: "\(userData.getCompletedTasksCount())"),
                            StatItem(title: "Days with Uncompleted Tasks", value: "\(userData.getNotCompletedTasksCount())"),
                            StatItem(title: "Current Streak", value: "\(userData.getCurrentStreak())"),
                            StatItem(title: "Best Streak", value: "\(userData.getBestStreak())"),
                            StatItem(title: "Journal Entries", value: "\(userData.getJournalEntriesCount())")
                        ])
                        
                        StatSection(title: "Task statistics", stats: [
                            StatItem(title: "Mind Tasks", value: "\(userData.getTasksCompletedByType(.mind))"),
                            StatItem(title: "Sport Tasks", value: "\(userData.getTasksCompletedByType(.sport))"),
                            StatItem(title: "Health Tasks", value: "\(userData.getTasksCompletedByType(.health))"),
                            StatItem(title: "Nutrition Tasks", value: "\(userData.getTasksCompletedByType(.nutrition))"),
                            StatItem(title: "Mental Tasks", value: "\(userData.getTasksCompletedByType(.mental))")
                        ])
                        
                        HStack(spacing: 24) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Sound")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.leading, 12)
                                
                                Toggle("", isOn: $isSoundEnabled)
                                    .labelsHidden()
                                    .toggleStyle(CustomToggleStyle())
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Vibro")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.leading, 12)
                                
                                Toggle("", isOn: $isVibroEnabled)
                                    .labelsHidden()
                                    .toggleStyle(CustomToggleStyle())
                            }
                        }
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 20) {
                            Button {
                                rateApp()
                            } label: {
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.color12)
                                    
                                    Text("Rate App")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.black)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .background(Color.white, in: .rect(cornerRadius: 100))
                            }
                            
                            Button {
                                shareApp()
                            } label: {
                                HStack {
                                    Image(.shareBlue)
                                        .resizable()
                                        .frame(width: 20, height: 18)
                                    
                                    Text("Share App")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.black)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .background(Color.white, in: .rect(cornerRadius: 100))
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        Button {
                            deleteAllData()
                        } label: {
                            HStack {
                                Image(.trash)
                                    .resizable()
                                    .frame(width: 16, height: 18)
                                
                                Text("Delete All Data")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.red)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.red.opacity(0.3), in: .rect(cornerRadius: 100))
                            .overlay {
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.red, lineWidth: 2)
                            }
                        }
                        .padding(.horizontal, 16)

                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    private func rateApp() {
        guard let url = URL(string: "itms-apps://apple.com/app/id6748654466") else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    private func shareApp() {
        let appURL = "https://apps.apple.com/app/id6748654466"
        let activityVC = UIActivityViewController(
            activityItems: ["Check out this amazing app: \(appURL)"],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityVC, animated: true)
        }
    }
    
    private func deleteAllData() {
        userData.resetAllData()
    }
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            
            Capsule()
                .fill(configuration.isOn ? Color.color5 : Color.color12)
                .frame(width: 116, height: 45)
                .overlay(
                    Circle()
                        .fill(configuration.isOn ? Color.color12 : Color.color5)
                        .frame(width: 41, height: 41)
                        .offset(x: configuration.isOn ? 35 : -35, y: 0)
                        .animation(.spring(), value: configuration.isOn)
                )
                .onTapGesture {
                    withAnimation {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

#Preview {
    StatisticsView()
        .environmentObject(UserData())
}
