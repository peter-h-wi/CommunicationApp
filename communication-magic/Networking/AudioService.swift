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

    var audioQueuePlayer : AVQueuePlayer?

    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let storageRef = FirebaseManager.shared.storage.reference()

    // check if recording has started , we will need it while playing with UI.
    @Published var isRecording : Bool = false
    @Published var isPlaying : Bool = false

    init() {
        let session = AVAudioSession.sharedInstance()
            do{
                try session.setCategory(.playAndRecord)
                try session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                try session.setActive(true)
            } catch {
                print ("\(#file) - \(#function) error: \(error.localizedDescription)")
            }
    }

    func startPlaying(url : String) {
        if audioQueuePlayer == nil {
                    audioQueuePlayer = AVQueuePlayer()
                    audioQueuePlayer?.play()
                }

                guard let player = audioQueuePlayer else {
                    print("AVQueuePlayer failed to instantiate!")
                    return
                }
                player.removeAllItems()

                let audioItem = AVPlayerItem(url: URL(string: url)!)
                player.insert(audioItem, after: nil)
                print("Played Successfully with AVQueuePlayaer")
    }

    func stopPlaying(url: String) {
        isPlaying = false
        audioQueuePlayer?.pause()
    }
    
    func resetAVPlayer() {
        self.audioQueuePlayer?.removeAllItems()
    }
}
