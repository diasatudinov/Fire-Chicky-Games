//
//  FCSongsManager.swift
//  Fire Chicky Games
//
//  Created by Dias Atudinov on 07.03.2025.
//


import AVFoundation

class FCSongsManager {
    static let shared = FCSongsManager()
    var audioPlayer: AVAudioPlayer?

    func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "chickenMusicFC", withExtension: "mp3") else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 
            audioPlayer?.play()
        } catch {
            print("Could not play background music: \(error)")
        }
    }

    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
}
