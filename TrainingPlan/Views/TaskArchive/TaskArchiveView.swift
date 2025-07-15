import SwiftUI

struct TaskArchiveView: View {
    
    @EnvironmentObject var userData: UserData
    
    @State private var selectedTask: DailyTask?
    
    @State private var showingTaskDetail = false
    
    var body: some View {
        ZStack {
            Image(.bgMain)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 14) {
                TitleView(title: "Task Archive")
                
                if userData.taskHistory.isEmpty {
                    VStack(spacing: 10) {
                        Image(.taskArchive)
                            .resizable()
                            .frame(width: 38, height: 38)
                        
                        Text("No completed tasks yet")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text("Complete your first task to see it here!")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white.opacity(0.7))
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(userData.taskHistory.sorted(by: { $0.date > $1.date }), id: \.self) { task in
                                TaskHistoryRow(task: task)
                                    .onTapGesture {
                                        selectedTask = task
                                        showingTaskDetail = true
                                    }
                            }
                        }
                        .padding(.bottom, 80)
                    }
                    .scrollIndicators(.hidden)
                    .padding(.top, 10)
                }
            }
            .padding(.horizontal, 16)
            
            ZStack {
                if showingTaskDetail, let task = selectedTask {
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                    
                    TaskDetailView(task: task) {
                        showingTaskDetail = false
                        selectedTask = nil
                    } shareAction: {
                        if let task = selectedTask {
                            let text = "I've \(task.isCompleate ? "completed" : "tried") this task in Training Plan app: \(task.text)"
                            shareApp(text: text)
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
            }
            .animation(.default, value: showingTaskDetail)
        }
    }
    
    private func shareApp(text: String) {
        let activityVC = UIActivityViewController(
            activityItems: ["Check out this amazing app: \(text)"],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityVC, animated: true)
        }
    }
}

#Preview {
    TaskArchiveView()
        .environmentObject(UserData())
}
