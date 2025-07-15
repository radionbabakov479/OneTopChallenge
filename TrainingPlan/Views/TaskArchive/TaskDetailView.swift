
import SwiftUI

struct TaskDetailView: View {
    
    let task: DailyTask
    
    let backAction: () -> Void
    let shareAction: () -> Void
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 0) {
            TitleView(title: "Task")
                .overlay(alignment: .leading) {
                    Button {
                        backAction()
                    } label: {
                        Image(.backArrow)
                            .resizable()
                            .frame(width: 26, height: 26)
                            .padding(.leading, 16)
                    }
                }
            
                VStack(spacing: 12) {
                    HStack {
                        Text(dateFormatter.string(from: task.date))
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.color4)
                            .frame(width: 120, height: 30)
                            .overlay {
                                RoundedRectangle(cornerRadius: 50)
                                    .strokeBorder(Color.color4, lineWidth: 2)
                            }
                        
                        Spacer()
                        
                        Text(task.isCompleate ? "Complited" : "Not Complited")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 120, height: 30)
                            .background(task.isCompleate ? Color.color3 : Color.color11, in: .rect(cornerRadius: 50))
                    }
                    
                    Image(task.category.imageName)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    
                    
                    Text(task.category.rawValue)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text(task.text)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    Button {
                        shareAction()
                    } label: {
                        HStack {
                            Image(.share)
                                .resizable()
                                .frame(width: 18, height: 20)
                            
                            Text("Share")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .frame(width: 164, height: 50)
                        .background(Color.color1, in: .rect(cornerRadius: 25))
                    }
                    .padding(.vertical, 12)
                }
                .padding(.top, 20)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 20)
        .background(Color.white, in: .rect(cornerRadius: 20))
        .padding(12)
    }
}
