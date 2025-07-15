
import SwiftUI
import AVKit

class SoundManager {
  
    @AppStorage("isSoundEnabled") var isSoundEnabled = true
    
    static let shared = SoundManager()
        
    var player: AVAudioPlayer?
        
    func playSound() {
        guard isSoundEnabled else { return }
        guard let url = Bundle.main.url(forResource: "button", withExtension: "wav") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private init () {}
}

class VibroManager {
    
    @AppStorage("isVibroEnabled") var isVibroEnabled = true
    
    static let shared = VibroManager()
    
    func vibrate() {
        guard isVibroEnabled else { return }
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }
    
    private init() {}
}

