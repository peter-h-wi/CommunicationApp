//
//  RecordVoiceViewModel.swift
//  communication-magic
//
//  Created by peter wi on 3/24/22.
//
import Foundation
import AVFoundation
import Firebase

class RecordVoiceViewModel : NSObject, ObservableObject , AVAudioPlayerDelegate{
    
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    
    var indexOfPlayer = 0
    let dateFormatter = DateFormatter()
    
    let member: Member = Member(uid: "fweew", name: "testmember", role: "doctor", online: true) //new stuff i added
    
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let storageRef = FirebaseManager.shared.storage.reference()
    
    var firestoreListener: ListenerRegistration?
    
    var toId: String
    
    @Published var memberTo: Member?
    @Published var groupTo: Group?
    @Published var sendToGroup: Bool

    // check if recording has started , we will need it while playing with UI.
    @Published var isRecording : Bool = false
    
    // Array to store our URL of recordings and some details, and the type of that array is Recording.
    @Published var recordingsList = [Recording]()
    @Published var messageList = [Message]()
    @Published var urlList = [String]()
    
    @Published var countSec = 0
    @Published var timerCount : Timer?
    @Published var blinkingCount : Timer?
    @Published var timer : String = "0:00"
    @Published var toggleColor : Bool = false
    @Published var isPlaying : Bool = false
    
    @Published var uploadStatus = ""
        
    var playingURL : URL?
    
    var audioName: String = ""
    
    var audioPlayer2: AVPlayer?
    var playingURL2 : String = ""
    
    // We are initialising and call a function here letter .
    init(memberTo: Member, groupTo: Group, sendToGroup: Bool) {
        self.memberTo = memberTo
        self.groupTo = groupTo
        self.sendToGroup = sendToGroup
        dateFormatter.dateFormat = "dd-MM-YY 'at' HH:mm:ss"
        if sendToGroup {
            toId = groupTo.id
        } else {
            toId = memberTo.id
        }
        super.init()

        switch AVCaptureDevice.authorizationStatus(for: .audio) {
            case .authorized: // The user has previously granted access to the audio.
                self.fetchAllRecording()
            
            case .notDetermined: // The user has not yet been asked for audio access.
                AVCaptureDevice.requestAccess(for: .audio) { granted in
                    if granted {
                        self.fetchAllRecording()
                    }
                }
            
            case .denied: // The user has previously denied access.
                return

            case .restricted: // The user can't grant access due to restrictions.
                return
        @unknown default:
            fatalError()
        }
        
       fetchAllRecording()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        for i in 0..<recordingsList.count {
            if recordingsList[i].fileURL == playingURL {
                recordingsList[i].isPlaying = false
            }
        }
    }
    
    // Creating the start recording function and doing some formalities , but there are some lines to understand are as follow .
    func startRecording() {
        // clear all recordings before start recording.
        deleteAllRecordings()
        
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
            
            timerCount = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (value) in
                self.countSec += 1
                self.timer = self.covertSecToMinAndHour(seconds: self.countSec)
            })
            blinkColor()
            
        } catch {
            print("Failed to Setup the Recording")
        }
    }
    
    
    // function to stop the recording and converting that recording variable as false.
    func stopRecording(){
        audioRecorder.stop()
        isRecording = false
        self.countSec = 0
        timerCount!.invalidate()
        blinkingCount!.invalidate()
        
        uploadRecording()
        self.timer = "0:00"
    }
    
    func deleteAllRecordings() {
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        for i in directoryContents {
            self.deleteRecording(url: i)
        }
    }
    
    func uploadRecording() {
        // url of files in the path
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        
        // audioFileRef -> inside child will be the name of the file.
        let audioFileRef = storageRef.child("audios/\(audioName)")
        audioFileRef.putFile(from: directoryContents[0], metadata: nil) { metadata, error in
            if let error = error {
                self.uploadStatus = "Failed to upload audio"
                print("Failed to upload audio: \(error)")
                return
            }
            
            audioFileRef.downloadURL { url, err in
                if let err = err {
                    self.uploadStatus = "Failed to retrieve audio URL"
                    print("Failed to retrieve downloadURL: \(err)")
                    return
                }
                
                guard let url = url else { return }
                self.uploadStatus = "Successfully uploaded audio"
                self.playingURL = url
                
                self.sendMessage(of: url)
            }
        }
    }
    
    func sendMessage(of url: URL) {
            guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }

            let messageData = ["audioURL": url.description, "groupID": toId, "senderID": fromId, "timestamp": Timestamp()] as [String: Any]

            if sendToGroup {
                let docRef = FirebaseManager.shared.firestore
                    .collection("Groups")
                .document("\(groupTo?.uid ?? "")")

                docRef.getDocument { (document, error) in
                    guard error == nil, let document = document, document.exists, let members = document.get("membersIds") as? [Any] else { return }

                    for member in members {
                        let memberMessageBox = FirebaseManager.shared.firestore
                            .collection("Messages")
                            .document(member as! String)
                            .collection("Messages")
                            .document()

                        memberMessageBox.setData(messageData) { error in
                            if let error = error {
                                self.uploadStatus = "Failed to send the message"
                                print("Failed to save message into Firestore: \(error)")
                                return
                            }
                            self.uploadStatus = "Successfully sent the message"
                            print("Successfully saved current user sending message")
                        }
                    }
                }
            } else {
                let document = FirebaseManager.shared.firestore
                    .collection("Messages")
                    .document(toId)
                    .collection("Messages")
                    .document()

                document.setData(messageData) { error in
                    if let error = error {
                        self.uploadStatus = "Failed to send the message"
                        print("Failed to save message into Firestore: \(error)")
                        return
                    }
                    self.uploadStatus = "Successfully sent the message"
                    print("Successfully saved current user sending message")
                }
            }
        }
    
    func downloadRecording() {
        recordingsList.removeAll()
                
        for url in urlList {
            let storage = Storage.storage().reference(forURL: "\(url)")
            
            storage.downloadURL { (url, error) in
                if let error = error {
                    print(error)
                    return
                } else {
                    let player = AVPlayer(url: url!)
                    player.play()
                }
            }
        }
    }
    
    
    func startPlaying2(url : String) {
        isPlaying = true
        playingURL2 = url
        let storage = Storage.storage().reference(forURL: url)
        storage.downloadURL { (url, error) in
            if let error = error {
                print("Failed downloading audio: \(error)")
                return
            }
            print("The URL is...: \(url!.absoluteURL)")
            self.audioPlayer2 = AVPlayer(url: url!.absoluteURL)
            self.audioPlayer2!.play()
            print("Played Successfully")
        }
    }
    
    func fetchAllRecording(){
        
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        
        // We are traveling in our directory of recordings and appending the recording in our array.
        for i in directoryContents {
            recordingsList.append(Recording(fileURL : i, createdAt:getFileDate(for: i), isPlaying: false))
        }
        
        // We are sorting the array as in descending order.
        recordingsList.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending})
        
    }
    
    // We are passing the url of recorded file , so that we can play that audio url only.
    func startPlaying(url : URL) {
        
        playingURL = url
        
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing failed in Device")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
            // Here we iterating over the list and making the isPlaying variable as true since it is playing now .
            for i in 0..<recordingsList.count {
                if recordingsList[i].fileURL == url {
                    recordingsList[i].isPlaying = true
                }
            }
            
        } catch {
            print("Playing Failed")
        }
        
        
    }
    
    func stopPlaying2(url: String) {
        isPlaying = false
        audioPlayer2?.pause()
    }
    
    
    // Stop playing will stop all the playing audios , but the reason we are taking the url is to toggle the variable in our list of recordings .
    func stopPlaying(url : URL) {
        
        audioPlayer.stop()
        // We are iterating in our list and making that recording file as false .
        for i in 0..<recordingsList.count {
            if recordingsList[i].fileURL == url {
                recordingsList[i].isPlaying = false
            }
        }
    }
    
    // To delete the recording from the system , we need their url .
    func deleteRecording(url : URL) {
        
        do {
            // In this line , we are deleting that recording .
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Can't delete")
        }
        
        // We are iterating over the our recording list and checking if the audio is playing , if playing then stop it the check if it is the recording we want to delete.
        for i in 0..<recordingsList.count {
            
            if recordingsList[i].fileURL == url {
                if recordingsList[i].isPlaying == true{
                    stopPlaying(url: recordingsList[i].fileURL)
                }
                // Finally we are deleting recording from our recording array .
                recordingsList.remove(at: i)
                
                break
            }
        }
    }
    
    func blinkColor() {
        
        blinkingCount = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (value) in
            self.toggleColor.toggle()
        })
        
    }
    
    
    func getFileDate(for file: URL) -> Date {
        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
            let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
            return creationDate
        } else {
            return Date()
        }
    }
}

extension RecordVoiceViewModel {
    func covertSecToMinAndHour(seconds : Int) -> String{
        
        let (_,m,s) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        let sec : String = s < 10 ? "0\(s)" : "\(s)"
        return "\(m):\(sec)"
        
    }
}
