
import SwiftUI

struct SelectedCardView: View {
    @EnvironmentObject var userData: UserData
    let task: DailyTask
    
    private let sound = SoundManager.shared
    private let vibro = VibroManager.shared
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Day card 1")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 120, height: 30)
                    .background(Color.color4, in: .rect(cornerRadius: 50))
                
                Spacer()
                
                Text(task.category.rawValue)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.color4)
                    .frame(width: 120, height: 30)
                    .background(Color.white, in: .rect(cornerRadius: 50))
                    .overlay {
                        RoundedRectangle(cornerRadius: 50)
                            .strokeBorder(Color.color4, lineWidth: 2)
                    }
            }
            
            Image(task.category.imageName)
                .resizable()
                .frame(width: 205, height: 205)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            
            Text(task.text)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(20)
            
            HStack(spacing: 6) {
                Button(action: {
                    userData.markTaskAsNotCompleted()
                    sound.playSound()
                    vibro.vibrate()
                }) {
                    Text("Did Not Complete")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(Color.color5, in: .rect(cornerRadius: 90))
                }
                
                Button(action: {
                    userData.markTaskAsCompleted()
                    sound.playSound()
                    vibro.vibrate()
                }) {
                    Text("Mark as Done")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(Color.color1, in: .rect(cornerRadius: 90))
                }
            }
        }
        .padding(16)
        .background(Color.white, in: .rect(cornerRadius: 20))
    }
}
