import SwiftUI

struct MyJournalView: View {
    
    @EnvironmentObject var userData: UserData
    @State private var journalText = "\"Write your thoughts here...\", \"How was your day?\""
    @State private var selectedMood: Mood?
    @State private var selectedEntry: DiaryEntry?
    
    @FocusState private var isTextEditorFocused: Bool
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Image(.bgMain)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 14) {
                    TitleView(title: "My Journal")
                    
                    VStack(spacing: 20) {
                        HStack(spacing: 12) {
                            ForEach(Mood.allCases) { mood in
                                Button {
                                    selectedMood = mood
                                } label: {
                                    VStack {
                                        Image(mood.icon)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                        
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(selectedMood == mood ? Color.white : .clear)
                                            .frame(width: 50, height: 4)
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 87)
                        .background(Color.color5, in: .rect(cornerRadius: 20))
                        
                        TextEditor(text: $journalText)
                            .focused($isTextEditorFocused)
                            .scrollContentBackground(.hidden)
                            .foregroundStyle(.black)
                            .frame(height: 186)
                            .padding(12)
                            .background(Color.white, in: .rect(cornerRadius: 20))
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Button("Cancel") {
                                        isTextEditorFocused = false
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                            }
                        
                        Button(action: saveEntry) {
                            Text("Save Today's Thought")
                                .font(.system(size: 21, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .background(
                                    LinearGradient(colors: [Color.color1, .color9],
                                                   startPoint: .top,
                                                   endPoint: .bottom), in: .rect(cornerRadius: 90)
                                )
                        }
                        .disabled(journalText.isEmpty || selectedMood == nil)
                        .opacity(journalText.isEmpty || selectedMood == nil ? 0.6 : 1.0)
                                                
                        if userData.diaryEntries.isEmpty {
                            VStack(spacing: 10) {
                                Image(.journal)
                                    .resizable()
                                    .frame(width: 38, height: 38)
                                
                                Text("No journal entries yet. Write your first thought!")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 200)
                            }
                            .padding(.bottom, 60)
                            .frame(maxHeight: .infinity)
                        } else {
                            ScrollView {
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("Past Entries")
                                        .font(.system(size: 22, weight: .semibold))
                                        .foregroundStyle(.white)
                                    
                                    ForEach(userData.diaryEntries.sorted(by: { $0.date > $1.date })) { entry in
                                        DiaryEntryRow(entry: entry)
                                    }
                                }
                                .padding(.bottom, 80)
                            }
                            .scrollIndicators(.hidden)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden()
        }
    }
    
    private func saveEntry() {
        guard let mood = selectedMood, !journalText.isEmpty else { return }
        
        let newEntry = DiaryEntry(
            text: journalText,
            mood: mood
        )
        
        userData.addDiaryEntry(newEntry)
        
        journalText = "\"Write your thoughts here...\", \"How was your day?\""
        selectedMood = nil
        
        SoundManager.shared.playSound()
        VibroManager.shared.vibrate()
    }
}

#Preview {
    MyJournalView()
        .environmentObject(UserData())
}
