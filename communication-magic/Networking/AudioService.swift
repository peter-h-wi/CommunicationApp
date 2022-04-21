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
    
    let audioQueuePlayer = AVQueuePlayer()
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let storageRef = FirebaseManager.shared.storage.reference()
    let session = AVAudioSession.sharedInstance()


    init() {
        do{
            try session.setCategory(.playAndRecord)
            try session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
            try session.setActive(true)
        } catch {
            print ("\(#file) - \(#function) error: \(error.localizedDescription)")
        }
        audioQueuePlayer.play()
    }
    
    func startPlaying(url : String) {
        resetAVPlayer()
        let audioItem = AVPlayerItem(url: URL(string: url)!)
        audioQueuePlayer.insert(audioItem, after: nil)
    }
    
    func startPlayingNextTime(url : String) {
        let audioItem = AVPlayerItem(url: URL(string: url)!)
        audioQueuePlayer.insert(audioItem, after: currentPlayingItem())
    }
    
    func addVoiceToQueue(url: String) {
        let audioItem = AVPlayerItem(url: URL(string: url)!)
        audioQueuePlayer.insert(audioItem, after: nil)
    }
    
    func stopPlaying(url: String) {
        audioQueuePlayer.pause()
    }
    
    func resetAVPlayer() {
        audioQueuePlayer.removeAllItems()
    }
    
    func currentPlayingItem() -> AVPlayerItem? {
        return audioQueuePlayer.currentItem
    }
}
