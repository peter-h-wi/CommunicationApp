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
    
    var playingURL : String = ""
    var audioName = ""
    var indexOfPlayer = 0
    let dateFormatter = DateFormatter()
    
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let storageRef = FirebaseManager.shared.storage.reference()
    
    // check if recording has started , we will need it while playing with UI.
    @Published var isRecording : Bool = false
    @Published var isPlaying : Bool = false

    // Array to store our URL of recordings and some details, and the type of that array is Recording.
    @Published var recordingsList = [Recording]()
    @Published var messageList = [Message]()
    @Published var urlList = [String]()
        
    init() {
        dateFormatter.dateFormat = "dd-MM-YY 'at' HH:mm:ss"
    }
    
    // Creating the start recording function and doing some formalities , but there are some lines to understand are as follow .
    func startRecording() {
        // clear all recordings before start recording.
        // deleteAllRecordings()
        
        let recordingSession = AVAudioSession.sharedInstance()
       
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { allowed in
                        DispatchQueue.main.async {
                            if allowed {
                                print("allowed")
                            } else {
                                print("not allowed")
                            }
                        }
                    }
        } catch {
            print("Cannot setup the Recording")
        }
        
        // a unique name to every recording file , so we are giving the name as current date and time . Notice the last words “.m4a” is really important to give . We are using a function call to fetch the current date into string . You can find that function in extension folder in project repository.
        audioName = "\(dateFormatter.string(from: Date())).m4a"
        let fileName = path.appendingPathComponent(audioName)

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            // When we started our recording successfully , then we are doing true that variable.
            isRecording = true
            
        } catch {
            print("Failed to Setup the Recording")
        }
    }
    
    // function to stop the recording and converting that recording variable as false.
    func stopRecording(){
        audioRecorder.stop()
        isRecording = false
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
            self.audioPlayer = AVPlayer(url: url!.absoluteURL)
            self.audioPlayer!.play()
            print("Played Successfully")
        }
    }
    
    func stopPlaying(url: String) {
        isPlaying = false
        audioPlayer?.pause()
    }
}
