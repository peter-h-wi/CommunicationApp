//
//  AudioService.swift
//  VoiceDelieverApp
//
//  Created by peter wi on 4/8/22.
//

import Foundation
import Firebase
import AVFoundation

final class AudioService: ObservableObject {
    
    static let shared = AudioService()
    
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVPlayer?
    var audioQueuePlayer : AVQueuePlayer?
    
    var playingURL : String = ""
    var audioName = ""
    var indexOfPlayer = 0
    let dateFormatter = DateFormatter()
    
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let storageRef = FirebaseManager.shared.storage.reference()
    
    // check if recording has started , we will need it while playing with UI.
    @Published var isRecording : Bool = false
    @Published var isPlaying : Bool = false

        
    init() {
        dateFormatter.dateFormat = "dd-MM-YY 'at' HH:mm:ss"
        audioQueuePlayer = AVQueuePlayer()
        audioQueuePlayer?.removeAllItems()
        audioQueuePlayer?.play()
    }
    
    func startPlaying(url : String) {
        isPlaying = true
        playingURL = url
        let storage = Storage.storage().reference(forURL: url)
        storage.downloadURL { (url, error) in
            if let error = error {
                print("Failed downloading audio: \(error)")
                return
            }
            print("The URL is...: \(url!.absoluteURL)")
            let audioItem = AVPlayerItem(url: url!.absoluteURL)
            self.audioQueuePlayer?.insert(audioItem, after: nil)
            print("Played Successfully")
        }
    }
    
    func stopPlaying(url: String) {
        isPlaying = false
        audioQueuePlayer?.pause()
    }
    
    func resetAVPlayer() {
        self.audioQueuePlayer?.removeAllItems()
    }
}
